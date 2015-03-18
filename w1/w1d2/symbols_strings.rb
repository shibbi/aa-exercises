def super_print(str, options = {})
  defaults = { times: 1, upcase: false, reverse: false }

  options = defaults.merge(options)
  options[:upcase] ? str.upcase! : str
  options[:reverse] ? str.reverse! : str

  options[:times].times { p str }

  nil
end
