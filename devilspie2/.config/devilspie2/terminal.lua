#!/bin/lua
do
    local classes = {'Simpleterm',
                     'Xfce4-terminal'}

    for _, class in ipairs(classes) do
        if (get_window_class() == class) then
            set_window_size(750, 400);
        end
    end
end
