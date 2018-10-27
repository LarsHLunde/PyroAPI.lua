-- PyroAPI v1.2

-- MIT License

-- Copyright (c) 2018 pyrokiller

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- To import add:
-- api = require "PyroAPI"

-- api.string_split(inputstr, sep)
-- splits a string according to seperator
-- uses white spaces as default
-- returns table

-- api.file_to_table(file)
-- converts file to table
-- returns table

-- api.file_to_string(file)
-- converts file to string
-- returns string

-- api.string_to_file(data,file)
-- puts string in to file
-- returns nothing

-- api.table_to_file(data,file)
-- puts table in to file
-- returns nothing

-- api.get_input(question)
-- gets user input
-- returns string

-- api.yes_or_no()
-- asks for a yes or no
-- returns boolean

-- api.execute_return(command)
-- asks for a command to be executed
-- returns string

-- api.replace_variables(file,keywords,replacees,replacers)
-- Finds a line in a file containing a keyword
-- and replaces part of the line with something else.
-- file - The file to be modified
-- keywords - A table of keywords that indentifies
-- the lines where replacement will be made
-- replacees - A table of parts of identified 
-- strings that is to be replaced
-- replacers - A table of replacement strings
-- for the for the replacees to be replaced by
-- returns nothing

-- api.replace_line(file,indentifier,replacer)
-- Finds a line in a file and replaces the line with a replacer
-- file - The file to be modified
-- identifier - The start of the line to be replaced
-- replacer - The line to replace the identified line
-- returns nothing


local PyroAPI = {}

function PyroAPI.string_split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			t[i] = str
			i = i + 1
	end
	return t
end

function PyroAPI.file_to_table(file)
	local fp = io.open(file, "rb")
	if fp == nil then
		print("ERROR: File doesn't exist")
	else
		local text = {}
		
		for line in fp:lines() do
			table.insert (text, line)
		end
		fp:close()
		return text
	end
end

function PyroAPI.file_to_string(file)
	local fp = io.open(file, "rb")
	if fp == nil then
		print("ERROR: File doesn't exist")
	else
		local content = fp:read("*all")
		fp:close()
		return content
	end
end

function PyroAPI.string_to_file(data,file)
	local fp = io.open(file,"w")
	fp:write(data)
	fp:close()
end

function PyroAPI.table_to_file(data,file)
	local fp = io.open(file,"w")
	for i=1, #data do
		fp:write(data[i] .. "\n")
	end
	fp:close()
end

function PyroAPI.get_input(question)
	io.write(question)
	io.flush()
	return io.read()
end

function PyroAPI.yes_or_no()
	local answer
	repeat
		io.write("Please answer with y for yes, or n for no: ")
		io.flush()
		answer=io.read()
	until answer=="y" or answer=="n"

	if answer == "y" then
		return true
	else
		return false
	end
end

function PyroAPI.execute_return(command)
	local fp = assert(io.popen(command, "r"))
	local output = fp:read("*all")
	fp:close()
	return(output)
end

function PyroAPI.replace_variables(file,keywords,replacees,replacers)
	local fp = io.open(file, "r")
	local text = {}
	
	if fp == nil then
		print("ERROR: File doesn't exist")
	else
		for line in fp:lines() do
			table.insert (text, line)
		end
		fp:close()
		
		for i = 1, #text do
			for j = 1, #keywords do
				if text[i]:match(keywords[j]) then
					text[i] = text[i]:gsub(replacees[j],replacers[j])
				end
			end
		end
		
		fp = io.open(file, "w")
		
		for i = 1, #text do
			fp:write(text[i] .. "\n")
		end
		fp:close()
	end
end


function PyroAPI.replace_line(file,indentifier,replacer)
	local fp = io.open(file, "r")
	local text = {}
	
	if fp == nil then
		print("ERROR: File doesn't exist")
	else
		for line in fp:lines() do
			table.insert (text, line)
		end
		fp:close()
		
		for i = 1, #text do
			if text[i]:sub(1,indentifier:len()) == indentifier then
				text[i] = replacer
			end
		end
		
		fp = io.open(file, "w")
		
		for i = 1, #text do
			fp:write(text[i] .. "\n")
		end
		fp:close()
	end
end

return PyroAPI
