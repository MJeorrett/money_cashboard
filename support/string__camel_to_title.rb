class String

  def camel_to_title()
    words = self.split( '_' )
    words.map! { |word| word.capitalize }
    title = words.join( " " )
    return title
  end

end
