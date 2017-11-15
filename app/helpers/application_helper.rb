module ApplicationHelper
	# 文字列が指定の長さ以上の場合は、以降を「...」に置き換える
  def cut_str(sentence, limit=50, pattern="...")
  	return "" unless sentence.present?

  	sentence.size > limit ? sentence[0, 50] + pattern : sentence
  end
end