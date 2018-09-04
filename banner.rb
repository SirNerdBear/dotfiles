#!/usr/bin/env ruby

require 'highline'
(cols,rows) = HighLine::SystemExtensions.terminal_size # [columns, rows]


#needs 42 cols min to display

logo_p1 = [" ::::::::   ::::::::  :::::::::  ::::::::::",
           ":+:    :+: :+:    :+: :+:    :+: :+:       ",
           "+:+        +:+    +:+ +:+    +:+ +:+       ",
           "+#+        +#+    +:+ +#+    +:+ +#++:++#  ",
           "+#+        +#+    +#+ +#+    +#+ +#+       ",
           "#+#    #+# #+#    #+# #+#    #+# #+#       ",
           " ########   ########  #########  ##########"]


#needs 52 cols min
#for both it would be 97 (3 spaces between)

logo_p2 = ["      ::::::::: ::::::::   ::::::::    :::   :::",
           "          :+: :+:    :+: :+:    :+:  :+:+: :+:+:",
           "        +:+  +:+    +:+ +:+    +:+ +:+ +:+:+ +:+",
           "      +#+   +#+    +:+ +#+    +:+ +#+  +:+  +#+ ",
           "    +#+    +#+    +#+ +#+    +#+ +#+       +#+  ",
           "  #+#     #+#    #+# #+#    #+# #+#       #+#   ",
           "######### ########   ########  ###       ###    "]

puts ""
if cols >= 97
  0.upto([logo_p1.size - 1,logo_p2.size - 1].max) do |index|
    puts "\e[34m#{logo_p1[index]}   \e[92m#{logo_p2[index]}"
  end
elsif cols >= 48
  indent = cols > 55 ? cols - 55 : 0
  puts "\e[34m#{logo_p1.join("\n")}"
  puts ""
  puts "\e[92m#{" " * indent}#{logo_p2.join("\n" + (" " * indent))}" 
else
  puts "\e[34mCode\e[92mZoom"
end


puts "\e[39m";
