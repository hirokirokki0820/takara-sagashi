module ApplicationHelper
  require "rqrcode"
  require "rqrcode_png"
  require "chunky_png"

  # QRコードを生成するメソッド
  # def qrcode_tag(url, options = {})
  #   if Rails.env.production?
  #     # 本番環境のみの処理
  #     qrcode = RQRCode::QRCode.new("https://qr-treasure-hunt.herokuapp.com#{url}")
  #   elsif Rails.env.development?
  #     # 開発環境のみの処理
  #     qrcode = RQRCode::QRCode.new(url)
  #   end
  #   return ChunkyPNG::Image.from_datastream(qrcode.as_png.resize(200,200).to_datastream).to_data_url
  # end

  def qrcode(url, size)
    if Rails.env.production?
      # 本番環境のみの処理
      qrcode = RQRCode::QRCode.new("https://qr-treasure-hunt.herokuapp.com#{url}")
    elsif Rails.env.development?
      # 開発環境のみの処理
      qrcode = RQRCode::QRCode.new(url)
    end
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: size,
      standalone: true,
      use_path: true
    ).html_safe
  end

  # bootstrapのアイコンを生成するメソッド
  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end

  # bootstrapの「アイコン＋文字列」を生成するメソッド
  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
  end

end
