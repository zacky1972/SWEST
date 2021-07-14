#!/usr/local/bin/ruby -Ku 
# -*- coding: utf-8 -*-
### おまじない
print "Content-Type: text/html\n\n"
###
require "cgi"
require 'net/smtp'
require 'kconv'

##定数
FORM_INDEX = 0
FILE_INDEX = 1

#繝代せ
LOG_PATH = "./logs/"
DATA_PATH = "./data/"
#ログファイルの拡張子
LOG_EXT = ".dat"

#####csv始まり
## CSV出力の順番にHTMLのnameを追加すること
CSV_ARRAY = Array::new
CSV_ARRAY.push "session_name"
CSV_ARRAY.push "title"
CSV_ARRAY.push "abst"
CSV_ARRAY.push "recommend"
CSV_ARRAY.push "twitter"
CSV_ARRAY.push "table_radio"
CSV_ARRAY.push "table"
CSV_ARRAY.push "projector_radio"
CSV_ARRAY.push "screen_radio"
CSV_ARRAY.push "wboard_radio"
CSV_ARRAY.push "microphone_radio"
CSV_ARRAY.push "microphone"
CSV_ARRAY.push "pointer_radio"
CSV_ARRAY.push "pointer"
CSV_ARRAY.push "other"
CSV_ARRAY.push "inform"
CSV_ARRAY.push "publish"
CSV_ARRAY.push "rokuon_radio"
CSV_ARRAY.push "totalReward"
CSV_ARRAY.push "name1"
CSV_ARRAY.push "inst_kind1"
CSV_ARRAY.push "affi1"
CSV_ARRAY.push "email1"
CSV_ARRAY.push "reward1_no"
CSV_ARRAY.push "reward1_unconfirm"
CSV_ARRAY.push "reward1_money"
CSV_ARRAY.push "reward1_money_id"
CSV_ARRAY.push "reward1_freefee"
CSV_ARRAY.push "reward1_travel"
CSV_ARRAY.push "reward1_travel_id"
#CSV_ARRAY.push "reward1_money"
#CSV_ARRAY.push "reward1_travel"
#CSV_ARRAY.push "recommend1"
CSV_ARRAY.push "bikou1"
CSV_ARRAY.push "name2"
CSV_ARRAY.push "inst_kind2"
CSV_ARRAY.push "affi2"
CSV_ARRAY.push "email2"
CSV_ARRAY.push "reward2_no"
CSV_ARRAY.push "reward2_unconfirm"
CSV_ARRAY.push "reward2_money"
CSV_ARRAY.push "reward2_money_id"
CSV_ARRAY.push "reward2_freefee"
CSV_ARRAY.push "reward2_travel"
CSV_ARRAY.push "reward2_travel_id"
#CSV_ARRAY.push "reward2_money"
#CSV_ARRAY.push "reward2_travel"
#CSV_ARRAY.push "reward2_radio"
#CSV_ARRAY.push "reward2_money"
#CSV_ARRAY.push "reward2_travel"
#CSV_ARRAY.push "recommend2"
CSV_ARRAY.push "bikou2"
CSV_ARRAY.push "name3"
CSV_ARRAY.push "inst_kind3"
CSV_ARRAY.push "affi3"
CSV_ARRAY.push "email3"
CSV_ARRAY.push "reward3_no"
CSV_ARRAY.push "reward3_unconfirm"
CSV_ARRAY.push "reward3_money"
CSV_ARRAY.push "reward3_money_id"
CSV_ARRAY.push "reward3_freefee"
CSV_ARRAY.push "reward3_travel"
CSV_ARRAY.push "reward3_travel_id"
#CSV_ARRAY.push "reward3_money"
#CSV_ARRAY.push "reward3_travel"
#CSV_ARRAY.push "reward3_radio"
#CSV_ARRAY.push "reward3_money"
#CSV_ARRAY.push "reward3_travel"
#CSV_ARRAY.push "recommend3"
CSV_ARRAY.push "bikou3"
CSV_ARRAY.push "name4"
CSV_ARRAY.push "inst_kind4"
CSV_ARRAY.push "affi4"
CSV_ARRAY.push "email4"
CSV_ARRAY.push "reward4_no"
CSV_ARRAY.push "reward4_unconfirm"
CSV_ARRAY.push "reward4_money"
CSV_ARRAY.push "reward4_money_id"
CSV_ARRAY.push "reward4_freefee"
CSV_ARRAY.push "reward4_travel"
CSV_ARRAY.push "reward4_travel_id"
#CSV_ARRAY.push "reward4_money"
#CSV_ARRAY.push "reward4_travel"
#CSV_ARRAY.push "reward4_radio"
#CSV_ARRAY.push "reward4_money"
#CSV_ARRAY.push "reward4_travel"
#CSV_ARRAY.push "recommend4"
CSV_ARRAY.push "bikou4"
CSV_ARRAY.push "name5"
CSV_ARRAY.push "inst_kind5"
CSV_ARRAY.push "affi5"
CSV_ARRAY.push "email5"
CSV_ARRAY.push "reward5_no"
CSV_ARRAY.push "reward5_unconfirm"
CSV_ARRAY.push "reward5_money"
CSV_ARRAY.push "reward5_money_id"
CSV_ARRAY.push "reward5_freefee"
CSV_ARRAY.push "reward5_travel"
CSV_ARRAY.push "reward5_travel_id"
#CSV_ARRAY.push "reward5_money"
#CSV_ARRAY.push "reward5_travel"
#CSV_ARRAY.push "reward5_radio"
#CSV_ARRAY.push "reward5_money"
#CSV_ARRAY.push "reward5_travel"
#CSV_ARRAY.push "recommend5"
CSV_ARRAY.push "bikou5"
CSV_ARRAY.push "name6"
CSV_ARRAY.push "inst_kind6"
CSV_ARRAY.push "affi6"
CSV_ARRAY.push "email6"
CSV_ARRAY.push "reward6_no"
CSV_ARRAY.push "reward6_unconfirm"
CSV_ARRAY.push "reward6_money"
CSV_ARRAY.push "reward6_money_id"
CSV_ARRAY.push "reward6_freefee"
CSV_ARRAY.push "reward6_travel"
CSV_ARRAY.push "reward6_travel_id"
#CSV_ARRAY.push "reward6_money"
#CSV_ARRAY.push "reward6_travel"
#CSV_ARRAY.push "reward6_radio"
#CSV_ARRAY.push "reward6_money"
#CSV_ARRAY.push "reward6_travel"
#CSV_ARRAY.push "recommend6"
CSV_ARRAY.push "bikou6"

CSV_ARRAY1 = Array::new
CSV_ARRAY1.push "name1"
CSV_ARRAY1.push "inst_kind1"
CSV_ARRAY1.push "affi1"
CSV_ARRAY1.push "pic1"
CSV_ARRAY1.push "email1"
CSV_ARRAY1.push "reward1_no"
CSV_ARRAY1.push "reward1_unconfirm"
CSV_ARRAY1.push "reward1_money"
CSV_ARRAY1.push "reward1_money_id"
CSV_ARRAY1.push "reward1_freefee"
CSV_ARRAY1.push "reward1_travel"
CSV_ARRAY1.push "reward1_travel_id"
#CSV_ARRAY1.push "recommend1"
CSV_ARRAY1.push "bikou1"

CSV_ARRAY2 = Array::new
CSV_ARRAY2.push "name2"
CSV_ARRAY2.push "inst_kind2"
CSV_ARRAY2.push "email2"
CSV_ARRAY2.push "affi2"
CSV_ARRAY2.push "email2"
CSV_ARRAY2.push "reward2_no"
CSV_ARRAY2.push "reward2_unconfirm"
CSV_ARRAY2.push "reward2_money"
CSV_ARRAY2.push "reward2_money_id"
CSV_ARRAY2.push "reward2_freefee"
CSV_ARRAY2.push "reward2_travel"
CSV_ARRAY2.push "reward2_travel_id"
#CSV_ARRAY2.push "reward2_radio"
#CSV_ARRAY2.push "reward2_money"
#CSV_ARRAY2.push "reward2_travel"
#CSV_ARRAY2.push "recommend2"
CSV_ARRAY2.push "bikou2"

CSV_ARRAY3 = Array::new
CSV_ARRAY3.push "name3"
CSV_ARRAY3.push "inst_kind3"
CSV_ARRAY3.push "pic3"
CSV_ARRAY3.push "affi3"
CSV_ARRAY3.push "email3"
#CSV_ARRAY3.push "reward3_radio"
#CSV_ARRAY3.push "reward3_money"
#CSV_ARRAY3.push "reward3_travel"
CSV_ARRAY3.push "reward3_no"
CSV_ARRAY3.push "reward3_unconfirm"
CSV_ARRAY3.push "reward3_money"
CSV_ARRAY3.push "reward3_money_id"
CSV_ARRAY3.push "reward3_freefee"
CSV_ARRAY3.push "reward3_travel"
CSV_ARRAY3.push "reward3_travel_id"
#CSV_ARRAY3.push "recommend3"
CSV_ARRAY3.push "bikou3"

CSV_ARRAY4 = Array::new
CSV_ARRAY4.push "name4"
CSV_ARRAY4.push "inst_kind4"
CSV_ARRAY4.push "pic4"
CSV_ARRAY4.push "affi4"
CSV_ARRAY4.push "email4"
CSV_ARRAY4.push "reward4_no"
CSV_ARRAY4.push "reward4_unconfirm"
CSV_ARRAY4.push "reward4_money"
CSV_ARRAY4.push "reward4_money_id"
CSV_ARRAY4.push "reward4_freefee"
CSV_ARRAY4.push "reward4_travel"
CSV_ARRAY4.push "reward4_travel_id"
#CSV_ARRAY4.push "reward4_radio"
#CSV_ARRAY4.push "reward4_money"
#CSV_ARRAY4.push "reward4_travel"
#CSV_ARRAY4.push "recommend4"
CSV_ARRAY4.push "bikou4"

CSV_ARRAY5 = Array::new
CSV_ARRAY5.push "name5"
CSV_ARRAY5.push "inst_kind5"
CSV_ARRAY5.push "pic5"
CSV_ARRAY5.push "affi5"
CSV_ARRAY5.push "email5"
CSV_ARRAY5.push "reward5_no"
CSV_ARRAY5.push "reward5_unconfirm"
CSV_ARRAY5.push "reward5_money"
CSV_ARRAY5.push "reward5_money_id"
CSV_ARRAY5.push "reward5_freefee"
CSV_ARRAY5.push "reward5_travel"
CSV_ARRAY5.push "reward5_travel_id"
#CSV_ARRAY5.push "reward5_radio"
#CSV_ARRAY5.push "reward5_money"
#CSV_ARRAY5.push "reward5_travel"
#CSV_ARRAY5.push "recommend5"
CSV_ARRAY5.push "bikou5"

CSV_ARRAY6 = Array::new
CSV_ARRAY6.push "name6"
CSV_ARRAY6.push "inst_kind6"
CSV_ARRAY6.push "pic6"
CSV_ARRAY6.push "affi6"
CSV_ARRAY6.push "email6"
CSV_ARRAY6.push "reward6_no"
CSV_ARRAY6.push "reward6_unconfirm"
CSV_ARRAY6.push "reward6_money"
CSV_ARRAY6.push "reward6_money_id"
CSV_ARRAY6.push "reward6_freefee"
CSV_ARRAY6.push "reward6_travel"
CSV_ARRAY6.push "reward6_travel_id"
#CSV_ARRAY6.push "reward6_radio"
#CSV_ARRAY6.push "reward6_money"
#CSV_ARRAY6.push "reward6_travel"
#CSV_ARRAY6.push "recommend6"
CSV_ARRAY6.push "bikou6"

# for secretary
CSV_ARRAY_HEAD = Array::new
CSV_ARRAY_HEAD.push "name"
#CSV_ARRAY_HEAD.push "pic"
CSV_ARRAY_HEAD.push "affi"
CSV_ARRAY_HEAD.push "email"
CSV_ARRAY_HEAD.push "reward_no"
CSV_ARRAY_HEAD.push "reward_unconfirm"
CSV_ARRAY_HEAD.push "reward_money"
CSV_ARRAY_HEAD.push "reward_money_id"
CSV_ARRAY_HEAD.push "reward_freefee"
CSV_ARRAY_HEAD.push "reward_travel"
CSV_ARRAY_HEAD.push "reward_travel_id"
#CSV_ARRAY_HEAD.push "reward_radio"
#CSV_ARRAY_HEAD.push "reward_money"
#CSV_ARRAY_HEAD.push "reward_travel"
#CSV_ARRAY_HEAD.push "recommend"
CSV_ARRAY_HEAD.push "bikou"

## HTMLのnameに対応するcsvファイルのヘッダの表示を指定する
RENAME_HASH = Hash::new
RENAME_HASH["session_name"] = "ID"
RENAME_HASH["title"] = "タイトル"
RENAME_HASH["abst"]="概要"
RENAME_HASH["recommend"]="推薦文"
RENAME_HASH["twitter"]="twitter用告知文"
RENAME_HASH["table_radio"]="机の配置"
RENAME_HASH["table"]="机の配置オプション"
RENAME_HASH["projector_radio"]="プロジェクタ"
RENAME_HASH["screen_radio"]="スクリーン"
RENAME_HASH["wboard_radio"]="ホワイトボード"
RENAME_HASH["microphone_radio"]="マイク"
RENAME_HASH["microphone"]="マイクの数"
RENAME_HASH["pointer_radio"]="ポインタ"
RENAME_HASH["pointer"]="ポインタの数"
RENAME_HASH["rokuon_radio"]="録音の確認"
RENAME_HASH["other"]="その他の備品"
RENAME_HASH["inform"]="参加者への連絡事項(持ち物など)"
RENAME_HASH["publish"]="ファイル一般公開の承認"
RENAME_HASH["totalReward"]="合計謝金"
RENAME_HASH["name1"]="講演者1氏名"
RENAME_HASH["inst_kind1"]="講演者1種別"
RENAME_HASH["affi1"]="講演者1所属"
RENAME_HASH["email1"]="講演者1連絡先"
RENAME_HASH["reward1_no"]="講演者1謝金等不要" 
RENAME_HASH["reward1_unconfirm"]="講演者1未確認" 
RENAME_HASH["reward1_money"]="講演者1謝金" 
RENAME_HASH["reward1_money_id"]="講演者1謝金金額" 
RENAME_HASH["reward1_freefee"]="講演者1参加費無料" 
RENAME_HASH["reward1_travel"]="講演者1旅費" 
RENAME_HASH["reward1_travel_id"]="講演者1旅費金額" 
#RENAME_HASH["reward1_radio"]="講演者1謝礼の種類"
#RENAME_HASH["reward1_money"]="講演者1謝金"
#RENAME_HASH["reward1_travel"]="講演者1旅費"
#RENAME_HASH["recommend1"]="講演者1推薦文"
RENAME_HASH["bikou1"]="講演者1備考"
RENAME_HASH["name2"]="講演者2氏名"
RENAME_HASH["inst_kind2"]="講演者2種別"
RENAME_HASH["pic2"]="講演者2顔写真"
RENAME_HASH["affi2"]="講演者2所属"
RENAME_HASH["email2"]="講演者2連絡先"
#RENAME_HASH["reward2_radio"]="講演者2謝礼の種類"
#RENAME_HASH["reward2_money"]="講演者2謝金"
#RENAME_HASH["reward2_travel"]="講演者2旅費"
#RENAME_HASH["recommend2"]="講演者2推薦文"
RENAME_HASH["reward2_no"]="講演者2謝金等不要" 
RENAME_HASH["reward2_unconfirm"]="講演者2未確認" 
RENAME_HASH["reward2_money"]="講演者2謝金" 
RENAME_HASH["reward2_money_id"]="講演者2謝金金額" 
RENAME_HASH["reward2_freefee"]="講演者2参加費無料" 
RENAME_HASH["reward2_travel"]="講演者2旅費" 
RENAME_HASH["reward2_travel_id"]="講演者2旅費金額" 
RENAME_HASH["bikou2"]="講演者2備考"
RENAME_HASH["name3"]="講演者3氏名"
RENAME_HASH["inst_kind3"]="講演者3種別"
RENAME_HASH["pic3"]="講演者3顔写真"
RENAME_HASH["affi3"]="講演者3所属"
RENAME_HASH["email3"]="講演者3連絡先"
RENAME_HASH["reward3_no"]="講演者3謝金等不要" 
RENAME_HASH["reward3_unconfirm"]="講演者3未確認" 
RENAME_HASH["reward3_money"]="講演者3謝金" 
RENAME_HASH["reward3_money_id"]="講演者3謝金金額" 
RENAME_HASH["reward3_freefee"]="講演者3参加費無料" 
RENAME_HASH["reward3_travel"]="講演者3旅費" 
RENAME_HASH["reward3_travel_id"]="講演者3旅費金額" 
#RENAME_HASH["reward3_radio"]="講演者3謝礼の種類"
#RENAME_HASH["reward3_money"]="講演者3謝金"
#RENAME_HASH["reward3_travel"]="講演者3旅費"
#RENAME_HASH["recommend3"]="講演者3推薦文"
RENAME_HASH["bikou3"]="講演者3備考"
RENAME_HASH["name4"]="講演者4氏名"
RENAME_HASH["inst_kind4"]="講演者4種別"
RENAME_HASH["pic4"]="講演者4顔写真"
RENAME_HASH["affi4"]="講演者4所属"
RENAME_HASH["email4"]="講演者4連絡先"
RENAME_HASH["reward4_no"]="講演者4謝金等不要" 
RENAME_HASH["reward4_unconfirm"]="講演者4未確認" 
RENAME_HASH["reward4_money"]="講演者4謝金" 
RENAME_HASH["reward4_money_id"]="講演者4謝金金額" 
RENAME_HASH["reward4_freefee"]="講演者4参加費無料" 
RENAME_HASH["reward4_travel"]="講演者4旅費" 
RENAME_HASH["reward4_travel_id"]="講演者4旅費金額" 
#RENAME_HASH["reward4_radio"]="講演者4謝礼の種類"
#RENAME_HASH["reward4_money"]="講演者4謝金"
#RENAME_HASH["reward4_travel"]="講演者4旅費"
#RENAME_HASH["recommend4"]="講演者4推薦文"
RENAME_HASH["bikou4"]="講演者4備考"
RENAME_HASH["name5"]="講演者5氏名"
RENAME_HASH["inst_kind5"]="講演者5種別"
RENAME_HASH["pic5"]="講演者5顔写真"
RENAME_HASH["affi5"]="講演者5所属"
RENAME_HASH["email5"]="講演者5連絡先"
RENAME_HASH["reward5_no"]="講演者5謝金等不要" 
RENAME_HASH["reward5_unconfirm"]="講演者5未確認" 
RENAME_HASH["reward5_money"]="講演者5謝金" 
RENAME_HASH["reward5_money_id"]="講演者5謝金金額" 
RENAME_HASH["reward5_freefee"]="講演者5参加費無料" 
RENAME_HASH["reward5_travel"]="講演者5旅費" 
RENAME_HASH["reward5_travel_id"]="講演者5金額" 
#RENAME_HASH["reward5_radio"]="講演者5謝礼の種類"
#RENAME_HASH["reward5_money"]="講演者5謝金"
#RENAME_HASH["reward5_travel"]="講演者5旅費"
#RENAME_HASH["recommend5"]="講演者5推薦文"
RENAME_HASH["bikou5"]="講演者5備考"
RENAME_HASH["name6"]="講演者6氏名"
RENAME_HASH["inst_kind6"]="講演者6種別"
RENAME_HASH["pic6"]="講演者6顔写真"
RENAME_HASH["affi6"]="講演者6所属"
RENAME_HASH["email6"]="講演者6連絡先"
RENAME_HASH["reward6_no"]="講演者6謝金等不要"
RENAME_HASH["reward6_unconfirm"]="講演者6未確認"
RENAME_HASH["reward6_money"]="講演者6謝金"
RENAME_HASH["reward6_money_id"]="講演者6謝金金額"
RENAME_HASH["reward6_freefee"]="講演者6参加費無料"
RENAME_HASH["reward6_travel"]="講演者6旅費"
RENAME_HASH["reward6_travel_id"]="講演者6金額"
#RENAME_HASH["reward6_radio"]="講演者6謝礼の種類"
#RENAME_HASH["reward6_money"]="講演者6謝金"
#RENAME_HASH["reward6_travel"]="講演者6旅費"
#RENAME_HASH["recommend6"]="講演者6推薦文"
RENAME_HASH["bikou6"]="講演者6備考"


RENAME_HASH1 = Hash::new
RENAME_HASH1["name"]="講演者氏名"
RENAME_HASH1["inst_kind"]="講演者種別"
#RENAME_HASH1["pic"]="講演者顔写真"
RENAME_HASH1["affi"]="講演者所属"
RENAME_HASH1["email"]="講演者連絡先"
RENAME_HASH1["reward_no"]="講演者謝金等不要" 
RENAME_HASH1["reward_unconfirm"]="講演者未確認" 
RENAME_HASH1["reward_money"]="講演者謝金" 
RENAME_HASH1["reward_money_id"]="講演者謝金金額" 
RENAME_HASH1["reward_freefee"]="講演者参加費無料" 
RENAME_HASH1["reward_travel"]="講演者旅費" 
RENAME_HASH1["reward_travel_id"]="講演者旅費金額" 
#RENAME_HASH1["reward_radio"]="講演者謝礼の種類"
#RENAME_HASH1["reward_money"]="講演者謝金"
#RENAME_HASH1["reward_travel"]="講演者旅費"
RENAME_HASH1["bikou"]="講演者備考"
##################################################

$IMG_BASE_PATH = "#{DATA_PATH}img/"

##################################################

## cgiの生成
$cgi = CGI.new

##################################################
def get_csv_header
  str = ""
  CSV_ARRAY.each{|item|
    str += "\"#{RENAME_HASH[item]}\","
  }
  str += "\n"
  return str
end

def get_csv_item(fname)
  str = ""
  fin = open("#{LOG_PATH}#{fname}")
  #情報毎の処理
  hash = Hash::new
  fin.each{|line|
    begin
      data = line.split("=")
    rescue => e
      print e
    end
    if data[1] != nil
      ##特殊文字を戻す
      data[1].gsub!("<<enter>>",";")
      data[1].gsub!("<<squot>>","'")
      data[1].gsub!("<<dquot>>","\"")
      data[1].gsub!("<<equal>>","=")
      hash[data[0]] = data[1].strip
    end
  }
  ## 順番に出力
  CSV_ARRAY.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  fin.close
  return str
end

def generate_csv
  csv_str = get_csv_header
  ##フォルダ内のファイルを取得
  Dir::foreach(LOG_PATH).sort.each{|fname|
    if fname =~ /\w[.]*dat/
      csv_str += get_csv_item(fname)
    end
  }

  str =	csv_str.kconv(Kconv::SJIS, Kconv::UTF8)
  fout = open("#{LOG_PATH}download.csv","w")
  fout.puts str
  fout.close
end

#####csv終わり

##################################################
def get_csv_header1
  str = ""
  CSV_ARRAY_HEAD.each{|item|
    str += "\"#{RENAME_HASH1[item]}\","
  }
  str += "\n"
  return str
end

def get_csv_item1(fname)
  str = ""
  fin = open("#{LOG_PATH}#{fname}")
  #情報毎の処理
  hash = Hash::new
  fin.each{|line|
    data = line.split("=")
    if data[1] != nil
      ##特殊文字を戻す
      data[1].gsub!("<<enter>>",";")
      data[1].gsub!("<<squot>>","'")
      data[1].gsub!("<<dquot>>","\"")
      data[1].gsub!("<<equal>>","=")
      hash[data[0]] = data[1].strip
    end
  }
  ## 順番に出力
  CSV_ARRAY1.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  CSV_ARRAY2.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  CSV_ARRAY3.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  CSV_ARRAY4.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  CSV_ARRAY5.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"
  CSV_ARRAY6.each{|item|
    str += "\"#{hash[item]}\","
  }
  str += "\n"

  fin.close
  return str
end

def generate_csv1
  srt = ""
  csv_str1 = get_csv_header1
  ##フォルダ内のファイルを取得
  Dir::foreach(LOG_PATH).sort.each{|fname|
    if fname =~ /\w[.]*dat/
      csv_str1 += get_csv_item1(fname)
    end
  }
#  fi = open("hogecacsa","r")
  str =	csv_str1.kconv(Kconv::SJIS, Kconv::UTF8)
  fout = open("#{LOG_PATH}secretary.csv","w")
  fout.puts str
  fout.close
end

#####csv終わり

def get_session_name(hash)
  #puts hash.length
  hash.each{|name, value|
    if name == "session_name"
      return value
    end
  }
  return nil
end

##ログの保存
def save_log(hash)
  ##ファイル名をフォームから取得
  fname = get_session_name(hash)
  if fname == nil
    puts "[!] session_name is empty<br/>"
    return false
  end

  fout = open("#{LOG_PATH}#{fname}#{LOG_EXT}","w")
  # フォームの情報を書き出す
  hash.each{|name, value|
    #puts name + "<br/>"
    #puts "    " + value + "<br/>"
    if name =~ /^pic\d$/
      # do nothing
    else
      value.gsub!("\r","")
      fout.puts "#{name}=#{value}\n"
    end
  }
  fout.close
end

def save_file(hash, sname)
  if sname == nil
    return false
  end
  
  hash.each{|elem, val|
    #puts $cgi[elem].original_filename
    ##ファイルを保存
    if $cgi[elem].original_filename =~ /\.(jpg|png|jpeg|JPG|PNG)$/ # 顔写真ファイル
      #puts $IMG_BASE_PATH
      File.write($IMG_BASE_PATH + $cgi[elem].original_filename, val)
    elsif $cgi[elem].original_filename != ""
      ##ファイルの種類(予稿集/Web公開/議事録)を取得
      type = elem.split("_")[1]
      ##拡張子を取得
      ext = File::extname($cgi[elem].original_filename)
      path = "#{DATA_PATH}#{sname}_#{type}#{ext}"
      ##画面表示
      print "<div align=\"center\">File for #{type} has been saved.</div>"
      ##保存
      fout = open(path,"w")
      fout.puts val
      fout.close

      ##ログにファイル情報を追加
      fout = open("#{LOG_PATH}#{sname}#{LOG_EXT}","a")
      fout.puts("filepath_#{type}=#{path}")
      ##日付を保存
      day = Time.now
      fout.puts("filedata_#{type}=#{day.year}/#{day.month}/#{day.day}")
      fout.close
    end
  }
end

## フォーム情報とファイル情報を区別する
def get_form
  dataHash = Hash::new
  fileHash = Hash::new

  $cgi.params.each{|name, value|
    if name =~ /^upfile.+$/
      fileHash[name] = $cgi[name].read
    elsif name =~ /filepath_pic\d/
      if not dataHash.key?(name)
        dataHash[name] = $cgi[name].read
      end
    elsif name =~ /filepath_.+$/
      if $cgi[name].read != ""
        dataHash[name] = $cgi[name].read
      end
    elsif name =~ /^pic.+$/
      fileHash[name] = $cgi[name].read
      if $cgi[name].original_filename != ''
        dataHash["filepath_" + name] = $cgi[name].original_filename
      end
    else
      dataHash[name] = $cgi[name].read
    end
  }

  if dataHash.length == 0
    puts "[!] form data is not given.<br/>"
  end
  return dataHash, fileHash
end

def main
  ##フォーム取得
  data = get_form
  if not data
    print "[!] No POST data"
    exit
  end
  sname = get_session_name(data[FORM_INDEX])
  ##ログを保存
  save_log(data[FORM_INDEX])
  ##ファイルの保存
  save_file(data[FILE_INDEX], sname)
  ##csvファイルを更新
  generate_csv()
  generate_csv1()
  ##確認画面を表示
  print "<HEAD>"
  print "<meta http-equiv=\"refresh\" content=\"1;./submit.html\" >"
  print "</HEAD>"
  print "<div align=\"center\">"
  print "Data have been updated.<br>"
  print "<a href=\"./submit.html\">back to edit page</a><br>"
  print "</div>"
end

f = open("#{LOG_PATH}seqno.lock",'w')
f.flock(File::LOCK_EX)
##排他区間はじまり
main

##排他区間終わり
f.flock(File::LOCK_UN)
f.close
