require pry

def foo bar
	if num.between?(0, 1)
		return [1]
	else
		f = foo(num - 1)
		p f
		f << f.last * (num - 1)
		f
	end
end

foo(5)


# symmetric_substrings

'aba'

def bar(str)
	[].tap { |agg|
		agg << str if str == str.reverse

		if 
	}
end


def baz(a, b, &c) #block c
end


[].take(1)
[].drop(1)


