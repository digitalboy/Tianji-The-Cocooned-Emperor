-- pandoc lua filter to convert [[wikilinks]] into proper links.
-- Handles two forms:
-- 1. [[link_target|display_text]] -> [display_text](link_target.md)
-- 2. [[link_target]]             -> [link_target](link_target.md)

function Str(el)
  local s = el.text
  -- Check for the presence of wikilinks to avoid unnecessary processing
  if not s:find("%[%[", 1, true) then
    return el
  end

  local inlines = {}
  local last_pos = 1

  -- Use gmatch to find all non-overlapping wikilink patterns
  for start_pos, end_pos, content in s:gmatch("()%[%[([^%]]+)%]%]()") do
    -- Add any text that appeared before this wikilink
    if start_pos > last_pos then
      table.insert(inlines, pandoc.Str(s:sub(last_pos, start_pos - 1)))
    end

    local link_target, link_text = content, content
    -- Check for a pipe separator to distinguish between the two forms
    local pipe_pos = content:find("|", 1, true)
    if pipe_pos then
      link_target = content:sub(1, pipe_pos - 1)
      link_text = content:sub(pipe_pos + 1)
    end

    -- Create a standard Pandoc Link element. Pandoc is smart enough to
    -- resolve the `.md` file to an internal anchor when creating the EPUB.
    table.insert(inlines, pandoc.Link(link_text, link_target .. ".md"))

    last_pos = end_pos + 1
  end

  -- Add any remaining text after the last wikilink
  if last_pos <= #s then
    table.insert(inlines, pandoc.Str(s:sub(last_pos)))
  end

  return #inlines > 0 and inlines or el
end