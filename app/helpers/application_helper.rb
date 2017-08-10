module ApplicationHelper
  def capitalize_words(words)
    stop_words = %w{ at by down for from in into like near of off on onto over past to upon with and as but for if nor once or so than that till when yet a an the }
    words.split.each_with_index.map{|word, index| stop_words.include?(word) && index > 0 ? word : word.capitalize }.join(" ")
  end

  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class: 'rounded_corners')
  end
end
