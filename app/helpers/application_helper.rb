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

  # 値なしのラベルのみを表示
  def only_label(title)
  	str = <<-EOS
		  <div class="form-group row">
		    <label class="col-sm-12 col-form-label">#{title}</label>
		  </div>
	  EOS
  end

  # 大きめのアイコン
  def big_circle_icon(src, alt="")
  	str = <<-EOS
		  <div class="form-group row">
		    <img class="d-flex mr-3 rounded-circle" src="#{src}" alt="#{alt}">
		  </div>
	  EOS
  end

  # 編集ボタン、削除ボタン
  def buttons(edit_path=nil, delete_path=nil)
  	str = <<-EOS
			<div class="btn-toolbar">
			  <div class="btn-group">
	  EOS

	  if edit_path.present?
	  	str << link_to('編集する', edit_path, class: "btn btn-primary")
	  end

	  if delete_path.present?
	  	str << link_to('削除する', delete_path, class: "btn btn-danger", data: { confirm: '本当に削除しますか？' })
	  end

  	str << <<-EOS
			  </div>
			</div>
	  EOS
	end

end