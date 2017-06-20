
# データベース上にサンプルポストを生成するRailsタスク
Post.create!(image:  "http://www.shinetsu-ks.com/media/1/20081203-20061116_192630.jpg",
             title: "海に行ってきました",
             text: "眺めが最高でした")

Post.create!(image: "http://www.yamakei-online.com/new_images/yamanavi/main_photo/18053_raw.jpg",
             title: "山に行ってきました",
             text: "景色が良かったです")

# データベース上にサンプルユーザーを生成するRailsタスク
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
