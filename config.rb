# coding: utf-8
require 'slim'
require 'csv'
require 'redcarpet'

preview = false

# allOptions = preview
allOptions = false

defaultOptions = "p0-s0-i0-r0-R1-S0"

buildBeforeDeploy = true

def change_logo navigation, logo
  nav = Marshal.load(Marshal.dump(navigation))
  i = nav[:logo] = logo
  nav
end

# constants

$site_url = 'http://localhost:4567/'

$navigation = {
  :logo => 'logo/SWEST_logo.svg',
	:site_url => '/',
	:site_name => 'SWEST',
	:items => [
		{
			:name => 'SWEST22について',
			:label => 'SWEST22',
			:url => '',
#                        :new => true,
		}, {
			:name => 'SWEST(エスウエスト)とは',
			:label => 'About',
			:url => 'about',
#                        :new => true,
		}, {
			:name => '開催案内',
			:label => 'Guide',
			:url => 'guide',
#                        :new => true,
#		}, {
#			:name => 'プログラム',
#			:label => 'Program',
#			:url => 'SWEST22/program/',
#                       :new => true,
#		}, {
#			:name => '20周年特別企画＠水曜',
#			:label => 'Wednesday',
#			:url => 'wednesday',
		}, {
			:name => '協賛のご案内',
			:label => 'Sponsor',
			:url => 'sponsor',
#                        :new => true,
		}, {
			:name => '過去のSWEST',
			:label => 'Old-report',
			:url => 'old-report'
		}, {
      :name => '討議テーマ・セッション募集',
      :label => 'Proposal',
      :url => 'proposal',
      :regist => true,
#      :new => true,
    }, {
      :name => 'インタラクティブセッション募集',
      :label => 'Interactive',
      :url => 'interactive',
      :regist => true,
#      :new => true,
    }, {
      :name => '参加申込み',
      :label => 'Regist',
      :url => 'regist',
      :regist => true,
#      :new => true,
    }
	]
}


activate :relative_assets

activate :external_pipeline, {
  name: :yarn,
  command: build? ? "yarn build" : "yarn watch",
  source: "./build",
  latency: 1
}

# activate :livereload

## GitHub Flavored Markdown
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true
set :markdown_engine, :redcarpet


# CSV モジュールにモンキーパッチを当てて Shift JIS の CSV を読み書きできるようにする

#module CSVEncodingExtension
#  def initialize(data, options = Hash.new)
#    options.delete(:replace)
#    options.delete(:undef)
#    super
#  end
#end

# CSV.send(:prepend, CSVEncodingExtension)

# lecture フォルダのデータ

$files = {
  SWEST19: "program-data/SWEST19/lecture/logs/{keynote,s{1,2,3,4,5}*}.dat",
  SWEST20: "program-data/SWEST20/lecture/logs/{keynote,s{1,2,3,4,5,s}*}.dat",
  SWEST21: "program-data/SWEST21/lecture/logs/{keynote,s{1,2,3,4,5}*}.dat",
  SWEST22: "program-data/SWEST22/lecture/logs/{keynote,s{1,2,3,4,5}*}.dat"
}

$current = 23

# セッションデータ

$sessions = {
  SWEST19: {
    date: [
      "8/24(木)",
      "8/25(金)",
    ],
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
      time: "14:40～15:00",
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
      time: "12:40～13:50",
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
  },
  SWEST20: {
    date: [
      "8/30(木)",
      "8/31(金)",
    ],
    page: [
      'index',
      'keynote',
      'interactive',
      'mokumoku',
      's1a', 's1b', 's1c', 's1d',
      's2a', 's2b', 's2c', 's2d',
      's3a', 's3b', 's3c', 's3d',
      's4a', 's4b', 's4c', 's4d',
      's5a', 's5b', 's5c', 's5d',
      'ss'
    ],
    icebreak: {
      date: "8/30(木)",
      time: "12:50～13:00",
      name: "アイスブレイク",
      title: "アイスブレイク",
      fullTitle: "アイスブレイク",
    },
    opening: {
      date: "8/30(木)",
      time: "13:00～13:20",
      name: "オープニング",
      title: "オープニング",
      fullTitle: "オープニング",
    },
    keynote: {
      date: "8/30(木)",
      time: "13:20～14:50",
      name: "基調パネル",
    },
    shortPresentation: {
      date: "8/30(木)",
      time: "14:50～15:00",
      name: "ショートプレゼンテーション",
      title: "ショートプレゼンテーション",
      fullTitle: "ショートプレゼンテーション",
    },
    interactive: {
      date: "8/30(木)",
      time: "15:00〜17:30",
      id: "interactive",
      name: "インタクティブセッション",
      title: "インタラクティブセッション",
      fullTitle: "インタラクティブセッション",
      abst: "研究発表・プロジェクト紹介・自由工作発表・協賛企業デモ展示をポスター形式で行います。"
    },
    dinner: {
      date: "8/30(木)",
      time: "18:30〜20:30",
      name: "懇親会",
      title: "懇親会",
      fullTitle: "懇親会",
    },
    s1: {
      date: "8/30(木)",
      time: "21:00〜22:30",
      name: "セッションS1",
      title: "夜の分科会",
    },
    s2: {
      date: "8/31(金)",
      time: "9:00～10:10",
      name: "セッションS2(70分)",
    },
    s3: {
      date: "8/31(金)",
      time: "10:25～11:15",
      name: "セッションS3(50分)",
    },
    s4: {
      date: "8/31(金)",
      time: "11:30～12:20",
      name: "セッションS4(50分)",
    },
    lunch: {
      date: "8/31(金)",
      time: "12:20〜13:00",
      name: "昼食",
      title: "昼食",
      fullTitle: "昼食",
    },
    s5: {
      date: "8/31(金)",
      time: "13:00～14:10",
      name: "セッションS5(70分)",
    },
    ss: {
      date: "8/31(金)",
      time: "14:30～15:40",
      name: "特別講演",
    },
    closing: {
      date: "8/31(金)",
      time: "15:45〜16:30",
      name: "クロージング",
      title: "クロージング",
      fullTitle: "クロージング",
    },
    mokumoku: {
      id: "mokumoku",
      name: "もくもく会",
      date: "8/31(金)",
      time: "9:00～15:40",
      title: "もくもく会",
      fullTitle: "もくもく会",
      abst: "SWESTの2日目にもくもく部屋を用意しています．<br/>使い方は自由です．<br/>セッションのハンズオン実習で進みきれなかったところや延長戦をやりたい！とか，インタラクティブセッションの自由工作品を見て開発意欲が湧いてきたからひたすら開発に励みたい！とか，もくもくとは言ってるけどフリーな議論で盛り上がりたい！も大歓迎です．"
    }
  },
  SWEST21: {
    date: [
      "9/5(木)",
      "9/6(金)",
    ],
    page: [
      'index',
      'keynote',
      'interactive',
      'mokumoku',
      's1a', 's1b', 's1c', 's1d', 's1e',
      's2a', 's2b', 's2c', 's2d',
      's3a', 's3b', 's3c', 's3d',
      's4a', 's4b', 's4c', 's4d',
      's5a', 's5b', 's5c', 's5d'
    ],
    icebreak: {
      date: "9/5(木)",
      time: "12:50～13:00",
      name: "アイスブレイク",
      title: "アイスブレイク",
      fullTitle: "アイスブレイク",
    },
    opening: {
      date: "9/5(木)",
      time: "13:00～13:20",
      name: "オープニング",
      title: "オープニング",
      fullTitle: "オープニング",
    },
    keynote: {
      date: "9/5(木)",
      time: "13:20～14:40",
      name: "基調講演",
    },
    shortPresentation: {
      date: "9/5(木)",
      time: "14:40～15:00",
      name: "ショートプレゼンテーション",
      title: "ショートプレゼンテーション",
      fullTitle: "ショートプレゼンテーション",
    },
    interactive: {
      date: "9/5(木)",
      time: "15:00〜17:30",
      id: "interactive",
      name: "インタクティブセッション ＆ EmbLT",
      title: "インタラクティブセッション ＆ EmbLT",
      fullTitle: "インタラクティブセッション ＆ EmbLT",
      abst: "研究発表・プロジェクト紹介・自由工作発表・協賛企業デモ展示をポスター形式で行います。 EmbLTもやりますよ！"
    },
    dinner: {
      date: "9/5(木)",
      time: "18:30〜20:30",
      name: "懇親会",
      title: "懇親会",
      fullTitle: "懇親会",
    },
    s1: {
      date: "9/5(木)",
      time: "21:00〜22:30",
      name: "セッションS1",
      title: "夜の分科会",
    },
    s2: {
      date: "9/6(金)",
      time: "9:00～10:10",
      name: "セッションS2(70分)",
    },
    s3: {
      date: "9/6(金)",
      time: "10:30～11:40",
      name: "セッションS3(70分)",
    },
    lunch: {
      date: "9/6(金)",
      time: "11:40〜12:40",
      name: "昼食",
      title: "昼食",
      fullTitle: "昼食",
    },
    s4: {
      date: "9/6(金)",
      time: "12:40～13:50",
      name: "セッションS4(70分)",
    },
    s5: {
      date: "9/6(金)",
      time: "14:10～15:20",
      name: "セッションS5(70分)",
    },
    closing: {
      date: "9/6(金)",
      time: "15:25〜16:00",
      name: "クロージング",
      title: "クロージング",
      fullTitle: "クロージング",
    },
    mokumoku: {
      id: "mokumoku",
      name: "もくもく会",
      date: "9/6(金)",
      time: "9:00～15:20",
      title: "もくもく会",
      fullTitle: "もくもく会",
    }
  },
  SWEST22: {
    date: [
      "8/20(木)",
      "8/21(金)",
    ],
    page: [
      'index',
      'keynote',
      'interactive',
#      'mokumoku',
      's1a', 's1b', 's1c', 's1d',
      's2a', 's2b', 's2c',
      's3a', 's3b', 's3c', 's3d',
      's4a', 's4b', 's4c', 's4d',
      's5a', 's5b', 's5c', 's5d'
    ],
    icebreak: {
      date: "8/20(木)",
      time: "12:00～13:00",
      name: "アイスブレイク ＆ LIVEガイダンス",
      title: "アイスブレイク ＆ LIVEガイダンス",
      fullTitle: "アイスブレイク ＆ LIVEガイダンス",
    },
    opening: {
      date: "8/20(木)",
      time: "13:00～13:20",
      name: "オープニング",
      title: "オープニング",
      fullTitle: "オープニング",
    },
    keynote: {
      date: "8/20(木)",
      time: "13:20～14:40",
      name: "特別企画",
    },
    break: {
      date: "8/20(木)",
      time: "14:40～15:00",
      name: "休憩",
      title: "休憩",
      fullTitle: "休憩",
    },
    shortPresentation: {
      date: "8/20(木)",
      time: "15:00～15:30",
      name: "ショートプレゼンテーション・Discord指南",
      title: "ショートプレゼンテーション・Discord指南",
      fullTitle: "ショートプレゼンテーション・Discord指南",
    },
    interactive: {
      date: "8/20(木)",
      time: "15:30〜17:30",
      id: "interactive",
      name: "インタクティブセッション",
      title: "インタラクティブセッション",
      fullTitle: "インタラクティブセッション",
      abst: "研究発表・プロジェクト紹介・自由工作発表・協賛企業デモ展示をポスター形式で行います。",
    },
    dinner: {
      date: "8/20(木)",
      time: "17:30〜19:30",
      name: "休憩",
      title: "休憩",
      fullTitle: "休憩",
    },
    s1: {
      date: "8/20(木)",
      time: "19:30〜21:00",
      name: "セッションS1",
      title: "夜の分科会",
    },
    s2: {
      date: "8/21(金)",
      time: "10:00～11:10",
      name: "セッションS2(70分)",
    },
    s3: {
      date: "8/21(金)",
      time: "11:30～12:40",
      name: "セッションS3(70分)",
    },
    lunch: {
      date: "8/21(金)",
      time: "12:40〜13:40",
      name: "昼食",
      title: "昼食",
      fullTitle: "昼食",
    },
    s4: {
      date: "8/21(金)",
      time: "13:40～14:50",
      name: "セッションS4(70分)",
    },
    s5: {
      date: "8/21(金)",
      time: "15:10～16:20",
      name: "セッションS5(70分)",
    },
    closing: {
      date: "8/21(金)",
      time: "16:25〜17:00",
      name: "クロージング",
      title: "クロージング",
      fullTitle: "クロージング",
    },
#    mokumoku: {
#      id: "mokumoku",
#      name: "もくもく会",
#      date: "8/21(金)",
#      time: "9:00～15:20",
#      title: "もくもく会",
#      fullTitle: "もくもく会",
#    }
  },
}

# セッションデータの読み込み

$files.each do |key, value|
  Dir.glob(value).each do |path|
    begin
      id = path.match(/.*\/([^\/].*)\.dat/)[1]
      id_s = id.to_sym
      unless id_s == :keynote || id_s == :ss then
        name = 'セッション' + id
        match = id.match(/(?<session>s[1-5s])(?<room>.*)/)
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

if(defined? $sessions && defined? $sessions[:SWEST19] && defined? $sessions[:SWEST19][:mokumoku] && defined? $sessions[:SWEST19][:s1d]) then
  s1d = $sessions[:SWEST19][:s1d]
  $sessions[:SWEST19][:mokumoku][:abst] = s1d[:abst] if defined? s1d[:abst]
  $sessions[:SWEST19][:mokumoku][:recommend] = s1d[:recommend] if defined? s1d[:recommend]
  $sessions[:SWEST19][:mokumoku][:name1] = s1d[:name1] if defined? s1d[:name1]
  $sessions[:SWEST19][:mokumoku][:filepath_pic1] = s1d[:filepath_pic1] if defined? s1d[:filepath_pic1]
  $sessions[:SWEST19][:mokumoku][:affi1] = s1d[:affi1] if defined? s1d[:affi1]
  $sessions[:SWEST19][:mokumoku][:name2] = s1d[:name2] if defined? s1d[:name2]
  $sessions[:SWEST19][:mokumoku][:filepath_pic2] = s1d[:filepath_pic2] if defined? s1d[:filepath_pic2]
  $sessions[:SWEST19][:mokumoku][:affi2] = s1d[:affi2] if defined? s1d[:affi2]
end

$sessions.each do |key, value|
  value.each_key do |id_s|
    unless id_s == :page || id_s == :date then
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
(19..22).each do |number|
#(19..21).each do |number|
  SWEST = "SWEST#{number}"
  csv_file = "./program-data/#{SWEST}/interactive-printable.csv"
  if File.exists?(csv_file) then
    begin
      $interactive[SWEST.to_sym] = CSV.read(csv_file, headers: false)
    rescue ArgumentError => ex
      $interactive[SWEST.to_sym] = CSV.read(csv_file, headers: false, encoding: "Shift_JIS:UTF-8")
    end
  end
end

option_table = [
  {
    id: :program,
    abbreviation: 'p',
    table: {
      "0" => :none,
      "1" => :pre,
      "2" => :session,
      "3" => :all
    }
  },
  {
    id: :proposal,
    abbreviation: 's',
    :table => {
      "0" => :disable,
      "1" => :enable,
      "2" => :finish
    }
  },
  {
    id: :interactive,
    abbreviation: 'i',
    :table => {
      "0" => :disable,
      "1" => :enable,
      "2" => :finish
    }
  },
  {
    id: :regist,
    abbreviation: 'r',
    :table => {
      "0" => :disable,
      "1" => :enable,
      "2" => :ppOnly,
      "3" => :finish,
    }
  },
  {
    id: :registOption,
    abbreviation: 'R',
    :table => {
      # "0" => :onlyDuring,
      "1" => :always
    }
  },
  {
    id: :submenu,
    abbreviation: 'S',
    :table => {
      "0" => :disable,
      # "1" => :enable
    }
  }
]

def getOptionsSingle hash
  a = hash[:abbreviation]
  options = {}
  hash[:table].each do |key, value|
    options["#{a}#{key}"] = {hash[:id] => value}
  end
  options
end

def defOptionsHash table
  h1 = {"" => {}}
  table.each do |original|
    o = getOptionsSingle(original)
    h2 = {}
    h1.each do |key1, value1|
      o.each do |key2, value2|
        key = "#{key1}-#{key2}"
        key.slice!(/^-/)
        value = value1.merge(value2)
        h2[key] = value
      end
    end
    h1 = h2
  end
  h1
end


options_hash = defOptionsHash(option_table)

options_hash.each do |path, options|
  options[:rootURL] = path + '/'
end


options_hash[""] = options_hash[defaultOptions]
options_hash[""][:rootURL] = ''

options_hash[""].each do |key, value|
  $navigation[key] = value
end

files = []
Dir.glob('source/src/**/*.html*') do |file|
  file = file.match(%r{^source/src/(.+\.html).*})[1]
  files.push(file)
end

options_hash.each do |path, options|
  if allOptions || path == '' then
    $navigation.each do |key, value|
      if options[key].nil? then
        options[key] = value
      end
    end
    files.each do |file|
      proxy "#{path}/#{file}", "src/#{file}", :locals => {locals: options}, ignore: true
    end
  end
end

# 動的ページの作成

[19, 20].each do |number|
#[19, 20, 22].each do |number|
  swest = "SWEST#{number.to_s}"
  $sessions[swest.to_sym][:page].each do |name|
    proxy "/#{swest}/program/#{name}.html", "/templates/timetable.html", locals: { session: name,  swest: swest, number: number, interactive: $interactive[swest.to_sym]}, ignore: true
  end
end

[21,22].each do |number|
#[21].each do |number|
  swest = "SWEST#{number.to_s}"
  $sessions[swest.to_sym][:page].each do |name|
    proxy "/#{swest}/program/#{name}.html", "/templates/timetable-#{swest}.html", locals: { session: name,  swest: swest, number: number, interactive: $interactive[swest.to_sym]}, ignore: true
  end
end

#{
#  'logo1': 'logo/SWEST_logo-01-20180307.jpg',
#  'logow': 'logo/SWEST_logo_WHITE.png'
#}.each do |l_id, logo|
#  $navigation = change_logo($navigation, logo)
#  proxy "#{l_id}/index.html", "/index.html"
#end

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
#    pattern = "https?://[a-zA-Z0-9.]{2,}(:[0-9]+)?(/[-_.!~*a-zA-Z0-9;/?:@&=+$,%#]+)?"
 #   /#{pattern}/ =~ text
    # $&という変数に格納されるので、それを利用してgsubメソッドで変換する
  #  text.gsub(/#{pattern}/,"<a href="+$&.to_s+">"+$&.to_s+"</a>")
    text.gsub(URI.regexp(['http', 'https'])) do |text|
      "<a href='#{text}'>#{text}</a>"
    end
  end

  def addSize2Pathname path, number, size
    p = Pathname(path)
    if number.nil? || number <= 20 || (p.basename('.*')).fnmatch("empty") then
      "#{p.dirname}/#{p.basename('.*')}.#{size.to_s}#{p.extname}"
    else
      "#{p.dirname}/SWEST#{number}/#{p.basename('.*')}.#{size.to_s}#{p.extname}"
    end
  end

  def link2SessionTitle sessions, name, id, number
    sid = "#{name}#{id}"
    sids = sid.to_sym
    if defined?(sessions) && defined?(sessions[sids]) && defined?(sessions[sids][:title]) then
      link_to sessions[sids][:title], "#{$site_url}SWEST#{number}/program/#{sid}.html##{name}"
    end
  end

  def getSession sessions, name
    sessions[name.to_sym]
  end

  def nilOrEmpty? poster
    poster.nil? || poster.empty?
  end

  def unlessNilOrEmpty messeage, poster
    messeage unless nilOrEmpty?(poster)
  end

  def picNumber number
    "filepath_pic#{number.to_s}".to_sym
  end

  def presenterPicture session, picNumber, number, size
    image_path(addSize2Pathname(session[picNumber], number, size))
  end

  def srcsetPresenter session, picNumber, number
    (1..3).to_a.reverse.map { |factor|
      "#{presenterPicture(session, picNumber, number, "#{factor}00".to_i)} #{factor}x"
    }.join(', ')
  end

  def srcsetKeyface image, number
    (1..3).to_a.reverse.map { |factor|
      "#{addSize2Pathname(image_path(image), number, "#{factor}00".to_i)} #{factor}x"
    }.join(', ')
  end

  def symAdd string, number
    "#{string}#{number.to_s}".to_sym
  end

  def presenceNowPlanning message
    message.presence || '企画中'
  end

  def textConvert message
    url2link(message.gsub(/<<enter>>/, "<br/>").gsub(/<<equal>>/, "=").gsub(/<<squot>>/, "&#39;").gsub(/<<dquot>>/, "&quot;"))
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
    # Use a build manifest to prevent re-compressing images between builds
    options.manifest = true

    # Silence problematic image_optim workers
    options.skip_missing_workers = false

    # Cause image_optim to be in shouty-mode
    options.verbose = false

    # Setting these to true or nil will let options determine them (recommended)
    options.nice = true
    options.threads = 8

    options.allow_lossy = true

    # Image extensions to attempt to compress
    options.image_extensions = %w(.jpg)

    # Compressor worker options, individual optimisers can be disabled by passing
    # false instead of a hash
    options.advpng    = { :level => 4 }
    options.gifsicle  = { :interlace => false }
    options.jpegoptim = { :strip => ['all'], :max_quality => 80 }
    options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
    options.optipng   = { :level => 6, :interlace => false }
    options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
    options.pngout    = { :copy_chunks => false, :strategy => 0 }
    options.svgo      = {}
  end

  # favicon-maker
  activate :favicon_maker do |f|
    f.template_dir  = 'source/images'
    f.icons = {
      "SWEST_favicon.png" => [
        { icon: "apple-touch-icon-180x180-precomposed.png" },
        { icon: "apple-touch-icon-152x152-precomposed.png" },
        { icon: "apple-touch-icon-144x144-precomposed.png" },
        { icon: "apple-touch-icon-114x114-precomposed.png" },
        { icon: "apple-touch-icon-72x72-precomposed.png" },
        { icon: "apple-touch-icon-precomposed.png", size: "60x60" },
        { icon: "mstile-144x144", format: :png },
        { icon: "favicon.png", size: "16x16" },
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      ]
    }
  end

  # キャッシュ対策のため，ファイル名にハッシュをつける。ただし，すでにハッシュが付与されているファイルを除く
  # activate :asset_hash, :ignore => /^.*\-[0-9a-f]{8}\..*/

  if preview then
    activate :asset_host, :host => 'https://zacky1972.github.io/SWEST'
    $site_url = 'https://zacky1972.github.io/SWEST/'
  else
    activate :asset_host, :host => 'https://swest.toppers.jp'
    $site_url = 'https://swest.toppers.jp/'
  end

  activate :iepab, {
    name: :gulpPost,
    command: "gulp post",
    source: "./build",
    latency: 1
  }
end

activate :deploy do |deploy|
  if preview then
  # for GitHub Pages
    deploy.build_before = buildBeforeDeploy
    deploy.deploy_method = :git
    deploy.branch = 'gh-pages'
  else
  # for swest.topper.jp
    deploy.build_before = buildBeforeDeploy
    deploy.deploy_method = :rsync
    deploy.host = 'swest.toppers.jp'
    deploy.path = '/var/www/html/'
    deploy.clean = false
    deploy.user = 'ec2-user'
    deploy.flags = '-rlOtcvz'
    deploy.port = '60022'
  end
end
