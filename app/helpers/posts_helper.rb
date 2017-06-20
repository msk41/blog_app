module PostsHelper

  # 年月件数表示のためのヘルパーメソッド
  def ymconvert(yyyymm, cnt)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]

    return yyyy + "年" + mm + "月 (" + cnt + ")"
  end

  # yyyy年MM月の投稿と表示するためのヘルパーメソッド
  def ymconvert_view(yyyymm)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]

    return yyyy + "年" + mm + "月"
  end
end
