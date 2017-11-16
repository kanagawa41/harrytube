module ApplicationHelper
	# 文字列が指定の長さ以上の場合は、以降を「...」に置き換える
  def cut_str(sentence, limit=50, pattern="...")
  	return "" unless sentence.present?

  	sentence.size > limit ? sentence[0, 50] + pattern : sentence
  end

	# リードオンリーのラベルを表示
  def item_label(title, value)
  	str = <<-EOS
		  <div class="form-group row">
		    <label class="col-sm-3 col-form-label">#{title}</label>
		    <div class="col-sm-9">
		      <p class="col-form-label">#{value}</p>
		    </div>
		  </div>
	  EOS
  end

  def only_label(title)
  	str = <<-EOS
		  <div class="form-group row">
		    <label class="col-sm-12 col-form-label">#{title}</label>
		  </div>
	  EOS
  end

end