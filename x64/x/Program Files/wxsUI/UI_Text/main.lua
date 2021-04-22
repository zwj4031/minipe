function onload()
    local text = get_option('-text')
    if text then
      if text:sub(1, 1) == '"' then text = text:sub(2, -2) end
      sui:find('label_info').text = text
    end
end
