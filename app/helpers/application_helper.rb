module ApplicationHelper
	# 文字列が指定の長さ以上の場合は、以降を「...」に置き換える
  def cut_str(sentence, limit=50, pattern="...")
  	return "" unless sentence.present?

  	sentence.size > limit ? sentence[0, 50] + pattern : sentence
  end

  # リードオンリーのラベルを表示(翻訳する)
  # model_and_attributeの形式はモデル名.属性名(product.name)
  def t_item_label(model_and_attribute, value)
    item_label(t('activerecord.attributes.' + model_and_attribute), value)
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
    # FIXME: 自前で用意したダミー画像を表示するようにする
    src = "http://placehold.it/150x150" unless src.present?

    str = <<-EOS
      #{image_tag src, alt: alt, class: "d-flex mr-3 rounded-circle img-responsive"}
    EOS
  end

  # サムネイルアイコン
  def thumbnail_icon(src, alt="")
    # FIXME: 自前で用意したダミー画像を表示するようにする
    src = "http://placehold.it/50x50" unless src.present?

    str = <<-EOS
      #{image_tag src, alt: alt, class: "d-flex mr-3 rounded-circle img-responsive", width: "50", hegiht: "50"}
    EOS
  end

  # ナビのアイコン
  # FIXME: 画像サイズをcssに記載する。
  def navi_icon(src, alt="")
    # FIXME: 自前で用意したダミー画像を表示するようにする
    src = "http://placehold.it/25x25" unless src.present?

    str = <<-EOS
      #{image_tag src, alt: alt, class: "d-flex mr-3 rounded-circle float-left img-responsive", style: "width: 25px; height: 25px;"}
    EOS
  end

  # 編集ボタン、削除ボタン
  def buttons(edit_path=nil, delete_path=nil)
  	str = <<-EOS
			<div class="btn-toolbar">
			  <div class="btn-group">
	  EOS

	  if edit_path.present?
	  	str << link_to('編集する', edit_path, class: "btn btn-outline-primary")
	  end

	  if delete_path.present?
	  	str << link_to('削除する', delete_path, method: :delete, class: "btn btn-outline-danger", data: { confirm: '本当に削除しますか？' })
	  end

  	str << <<-EOS
			  </div>
			</div>
	  EOS
	end

  # 安全に文字列結合を行う
  # ※いずれも空白の場合は空白を返却する
  def concat_safe(base_val, *vals)
    all_str = ""
    vals.each do |val|
      all_str << val.to_s if val.present?
    end

    all_str.present? ? base_val.to_s + all_str : ""
  end
end