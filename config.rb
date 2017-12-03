require 'slim'

# constants

$site_url = ''

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

# webpack

activate :external_pipeline, {
	name: :webpack,
	command: build? ?
		"NODE_ENV=production npm run build" :
		"NODE_ENV=develop npm run develop",
	source: "./build",
	latency: 1
}

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
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  activate :asset_hash
  activate :asset_host, :host => 'https://zacky1972.github.io/SWEST'
  $site_url = '/SWEST'
end

activate :deploy do |deploy|
	deploy.build_before = true
	deploy.deploy_method = :git
	deploy.branch = 'gh-pages'
end
