module ApplicationHelper
  def page_title(title = "")
    base_title = "フリマップ"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def page_description(description = "")
    base_description = "フリマップは、フリーマーケットの開催情報を地図上から探せるWebアプリです。開催場所を地図上のマーカーで確認でき、「フリマを探す」と「場所を調べる」を一つの体験として提供します。"
    description.presence || base_description
  end
end
