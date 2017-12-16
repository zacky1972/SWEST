require 'slim'
require 'csv'

# constants

$site_url = 'http://localhost:4567/'

$navigation = {
	:site_url => '/',
	:site_name => 'SWEST',
	:items => [
		{
			:name => 'Top',
			:label => 'Top',
			:url => '/',
			:dropdown => [
				{
					:name => 'SWEST開催概要',
					:url => '/#abst'
				}, {
					:name => 'SWESTとは？',
					:url => '/#whatis'
				}, {
					:name => 'お問い合わせ',
					:url => '/#contact'
				}
			]
		}, {
			:name => '開催案内',
			:label => 'Guide',
			:url => '/guide',
			:dropdown => [
				{
					:name => '会場・日時',
					:url => '/guide#date'
				}, {
					:name => 'メインテーマ',
					:url => '/guide#theme'
				}, {
					:name => '企画内容',
					:url => '/guide#abst'
				}, {
					:name => '主催・共催・後援・協賛',
					:url => '/guide#org'
				}, {
					:name => 'ちらし',
					:url => '/guide#phamplet'
				}, {
					:name => '会場アクセス',
					:url => '/guide#venue'
				}
			]
		}, {
			:name => 'プログラム',
			:label => 'Program',
			:url => '/SWEST19/program/',
		}, {
			:name => '協賛のご案内',
			:label => 'Sponsor',
			:url => '/sponsor',
			:dropdown => [
				{
					:name => 'ご案内と協賛のメリット',
					:url => '/sponsor#guide'
				}, {
					:name => 'お申し込み方法',
					:url => '/sponsor#appl'
				}
			]
		}, {
			:name => 'コミュニティ',
			:label => 'Community',
			:url => '/community',
			:dropdown => [
				{
					:name => 'メーリングリスト',
					:url => '/community#ml'
				}, {
					:name => 'SNS',
					:url => '/community#sns'
				}
			]
		}, {
			:name => '問合わせ先・運営組織',
			:label => 'Members',
			:url => '/members',
			:dropdown => [
				{
					:name => '問合わせ先',
					:url => '/members#contact'
				}, {
					:name => '運営組織',
					:url => '/members#org'
				}
			]
		}, {
			:name => '過去のSWEST',
			:label => 'Old-report',
			:url => '/old-report',
			:dropdown => [
				{
					:name => '実施報告書',
					:url => '/old-report#report'
				}, {
					:name => 'プログラム・議事録・実施風景',
					:url => '/old-report#program'
				}, {
					:name => '参加者のみなさまのレポート',
					:url => '/old-report#part'
				}
			]
		}, {
			:name => '情報公開ガイドライン',
			:label => 'Guideline',
			:url => '/guideline'
		}
	]
}

activate :relative_assets

activate :external_pipeline, {
	name: :parcel,
	command: "parcel build source/javascripts/site.js --out-dir build/javascripts/",
	source: "./build",
	latency: 1
}

activate :external_pipeline, {
	name: :gulp,
	command: "gulp build",
	source: "./build",
	latency: 1
}

activate :livereload

# CSV モジュールにモンキーパッチを当てて Shift JIS の CSV を読み書きできるようにする

module CSVEncodingExtension
  def initialize(data, options = Hash.new)
    options.delete(:replace)
    options.delete(:undef)
    super
  end
end

CSV.send(:prepend, CSVEncodingExtension)

# lecture フォルダのデータ

$files = {
  SWEST19: "lecture/logs/{keynote,s{1,2,3,4,5}*}.dat"
}

# セッションデータ

$sessions = {
  SWEST19: {
    page: [
      'index', 
      'keynote', 
      'interactive', 
      'mokumoku', 
      's1a', 's1b', 's1c', 's1d', 
      's2a', 's2b', 's2c', 's2d', 
      's3a', 's3b', 's3c', 's3d', 
      's4a', 's4b', 's4c', 's4d', 
      's5a', 's5b', 's5c', 's5d'
    ],
    icebreak: {
      date: "8/24(木)",
      time: "12:50～13:00",
      name: "アイスブレイク",
      title: "アイスブレイク",
      fullTitle: "アイスブレイク",
    },
    opening: {
      date: "8/24(木)",
      time: "13:00～13:20",
      name: "オープニング",
      title: "オープニング",
      fullTitle: "オープニング",
    },
    keynote: {
      date: "8/24(木)",
      time: "13:20～14:40",
      name: "基調講演",
    },
    shortPresentation: {
      date: "8/24(木)",
      time: "13:20～14:40",
      name: "ショートプレゼンテーション",
      title: "ショートプレゼンテーション",
      fullTitle: "ショートプレゼンテーション",
    },
    interactive: {
      date: "8/24(木)",
      time: "15:00〜17:30",
      id: "interactive",
      name: "インタクティブセッション",
      title: "インタラクティブセッション",
      fullTitle: "インタラクティブセッション",
      abst: "研究発表・プロジェクト紹介・自由工作発表・協賛企業デモ展示をポスター形式で行います。"
    },
    dinner: {
      date: "8/24(木)",
      time: "18:30〜20:30",
      name: "懇親会",
      title: "懇親会",
      fullTitle: "懇親会",
    },
    s1: {
      date: "8/24(木)",
      time: "21:00〜22:30",
      name: "セッションS1",
      title: "夜の分科会",
    },
    s2: {
      date: "8/25(金)",
      time: "9:00～10:10",
      name: "セッションS2(70分)",
    },
    s3: {
      date: "8/25(金)",
      time: "10:30～11:40",
      name: "セッションS3(70分)",
    },
    lunch: {
      date: "8/25(金)",
      time: "11:40〜13:00",
      name: "昼食",
      title: "昼食",
      fullTitle: "昼食",
    },
    s4: {
      date: "8/25(金)",
      time: "13:00～13:10",
      name: "セッションS4(70分)",
    },
    s5: {
      date: "8/25(金)",
      time: "14:30～15:40",
      name: "セッションS5(70分)",
    },
    closing: {
      date: "8/25(金)",
      time: "15:45〜16:30",
      name: "クロージング",
      title: "クロージング",
      fullTitle: "クロージング",
    },
    mokumoku: {
      id: "mokumoku",
      name: "カーネルもくもく会",
      date: "8/25(金)",
      time: "9:00～15:40",
      title: "カーネルもくもく会",
      fullTitle: "カーネルもくもく会",
    }
  }
}

# セッションデータの読み込み

$files.each do |key, value|
  Dir.glob(value).each do |path|
    begin
      id = path.match(/.*\/([^\/].*)\.dat/)[1]
      id_s = id.to_sym
      unless id_s == :keynote then
        name = 'セッション' + id
        match = id.match(/(?<session>s[1-5])(?<room>.*)/)
        session = match[:session]
        session_s = session.to_sym
        $sessions[key][id_s] = $sessions[key][session_s].dup
        $sessions[key][id_s][:name] = name
      end
      File.open(path) do |file|
        file.read.split("\n").each do |line|
          tmp = line.split('=', 2)
          $sessions[key][id_s][tmp[0].strip.to_sym] = tmp[1].strip
        end
      end
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    rescue IOError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    end
  end
end

$sessions[:SWEST19][:mokumoku][:abst] = $sessions[:SWEST19][:s1d][:abst]
$sessions[:SWEST19][:mokumoku][:recommend] = $sessions[:SWEST19][:s1d][:recommend]
$sessions[:SWEST19][:mokumoku][:name1] = $sessions[:SWEST19][:s1d][:name1]
$sessions[:SWEST19][:mokumoku][:filepath_pic1] = $sessions[:SWEST19][:s1d][:filepath_pic1]
$sessions[:SWEST19][:mokumoku][:affi1] = $sessions[:SWEST19][:s1d][:affi1]
$sessions[:SWEST19][:mokumoku][:name2] = $sessions[:SWEST19][:s1d][:name2]
$sessions[:SWEST19][:mokumoku][:filepath_pic2] = $sessions[:SWEST19][:s1d][:filepath_pic2]
$sessions[:SWEST19][:mokumoku][:affi2] = $sessions[:SWEST19][:s1d][:affi2]

$sessions.each do |key, value|
  value.each_key do |id_s|
    unless id_s == :page then
      name = $sessions[key][id_s][:name]
      title = $sessions[key][id_s][:title]
      unless name.nil? then
        if $sessions[key][id_s][:fullTitle].nil?
          if title.nil? then
            $sessions[key][id_s][:fullTitle] = name
          else
            $sessions[key][id_s][:fullTitle] = name + ": " + title
          end
        end
      end
      (1..5).each do |number|
        if $sessions[key][id_s]["name#{number.to_s}".to_sym].present? then
          image = $sessions[key][id_s]["filepath_pic#{number.to_s}".to_sym]
          ogp_image = image
          if image.blank? then
            image = 'empty.jpg'
            ogp_image = 'swestlogo.png'
          elsif /\.(jpg|JPG|jpeg|JPEG)/.match(Pathname(image).extname)
            image = Pathname(image).sub_ext('.jpg').to_s
            ogp_image = image
          elsif /\.(png|PNG)/.match(Pathname(image).extname)
            image = Pathname(image).sub_ext('.png').to_s
            ogp_image = image
          end
          $sessions[key][id_s]["filepath_pic#{number.to_s}".to_sym] = image
          if number == 1 then
            $sessions[key][id_s][:ogp_image] = ogp_image
          end
        end
      end
    end 
  end
end


# インタラクティブセッションの読み込み

$interactive = Hash.new
if File.exists?("interactive-printable.csv") then
  $interactive[:SWEST19] = CSV.read("interactive-printable.csv", headers: false, encoding: "Shift_JIS:UTF-8")
end

# 動的ページの作成

[19].each do |number|
  swest = "SWEST#{number.to_s}"
  $sessions[swest.to_sym][:page].each do |name|
    proxy "/#{swest}/program/#{name}.html", "/templates/timetable.html", locals: { session: name }, ignore: true
  end
end

# OGP

activate :ogp do |ogp|
  ogp.namespaces = {
    fb: data.ogp.fb,
    og: data.ogp.og
  }
  ogp.base_url = 'https://swest.toppers.jp'
  ogp.blog = true
end

###
# Page options, layouts, aliases and proxies
###


# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', locals: {
#  which_fake_page: 'Rendering a fake page with a local variable' }

###
# Helpers
###

helpers do
  def nav_add navigation, name, tag, value
  	nav = Marshal.load(Marshal.dump(navigation))
  	i = nav[:items].find{|item| item[:label].eql? name}
  	unless i.nil?
  		i[tag] = value
  	end
  	nav
  end

  def url2link text
    pattern = "https?://[a-zA-Z0-9.]{2,}(:[0-9]+)?(/[-_.!~*a-zA-Z0-9;/?:@&=+$,%#]+)?"
    /#{pattern}/ =~ text
    # $&という変数に格納されるので、それを利用してgsubメソッドで変換する
    text.gsub(/#{pattern}/,"<a href="+$&.to_s+">"+$&.to_s+"</a>")
  end
end

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
configure :build do
  # Autoprefixer
  activate :autoprefixer do |config|
    config.cascade = false
    config.inline = true
    config.ignore = ['/common']
  end

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Minify Image
  activate :imageoptim do |options|
    options.pngout = false
    options.svgo =false
  end

  activate :asset_hash
#  activate :asset_host, :host => 'https://zacky1972.github.io/SWEST'
#  $site_url = '/SWEST/'
  activate :asset_host, :host => 'https://swest.toppers.jp'
  $site_url = 'https://swest.toppers.jp/'

end

activate :deploy do |deploy|
# for GitHub Pages
#	deploy.build_before = true
#	deploy.deploy_method = :git
#	deploy.branch = 'gh-pages'

# for swest.topper.jp
  deploy.build_before = true
  deploy.deploy_method = :rsync
  deploy.host = 'swest.toppers.jp'
  deploy.path = '/var/www/html/'
  deploy.clean = false
end
