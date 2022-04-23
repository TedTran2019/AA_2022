module ApplicationHelper
  def auth_token
    "<input type='hidden' name='authenticity_token' value='#{h(form_authenticity_token)}'>".html_safe
  end

  def hidden_method(method)
    "<input type='hidden' name='_method' value='#{h(method)}'>".html_safe
  end

  def ugly_lyrics(lyrics)
    "<pre>#{lyrics.split("\n").map { |lyric| "&#9835" + ' ' + h(lyric) }.join("\n")}</pre>".html_safe
  end
end
