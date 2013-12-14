crazy_email_regex = Regexp.new('/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/')

puts crazy_email_regex.match("abe.schonfeld@gmail.com")

puts "abe.schonfeld-gmail.com".match(crazy_email_regex)