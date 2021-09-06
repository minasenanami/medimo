# medimo
![home](https://user-images.githubusercontent.com/66349813/132168372-78f65a65-f13d-4ab7-9e8e-218e91351e17.gif)



## URL
- アプリURL: https://medimov1.herokuapp.com
- Qiitaに詳細記事を準備中です。

## アプリ概要
「看護に関する知識を記録・共有」をテーマにしたアプリで特徴は以下です。

- 看護に関する記事の作成・編集・削除機能
- 記事は「公開・下書き・非公開」の公開範囲の選択が可能
- 記事への「いいね」と「保存」機能実装し「保存」した記事は一覧で閲覧可能
- 記事のタイトル or タグ検索機能




## 使用イメージ

### ゲストログイン
![guest](https://user-images.githubusercontent.com/66349813/132167522-a84e6197-e2ec-4571-ac0d-3ea3f85a9313.gif)

### 投稿機能 / 詳細
![create](https://user-images.githubusercontent.com/66349813/132167489-91ff8388-396c-4bb1-b4af-9ff7b2a32494.gif)

### いいね・保存機能
![likekeep](https://user-images.githubusercontent.com/66349813/132167544-a596ede5-27f7-4aee-930c-fe819da7533e.gif)


### マイページ
![mypage](https://user-images.githubusercontent.com/66349813/132167548-000d3bdc-aa98-4755-b570-df36cfc7cc61.gif)


### 保存記事一覧
![keeppage](https://user-images.githubusercontent.com/66349813/132167540-b767d832-8a3f-43d0-a246-4a28d4ac6caf.gif)


### 記事・タグ検索
![searchtag](https://user-images.githubusercontent.com/66349813/132167549-525aace8-d2a1-446d-bb08-05634d125050.gif)




## 制作背景

看護師として 5 年ほど勤務していた際に、教育担当や新人の方から以下の相談が多々ありました。

1. ネットは一般向けな内容なので欲しい情報に至るまでに時間がかかる
1. 毎日課題が多い
   - 翌日の担当患者さんの病態生理の把握
   - 薬剤治療前後の注意点
   - 検査値・項目の理解 etc...
1. ケア・業務内容の種類が多く頻度の少ない物は忘れてしまう

この課題は私の職場だけに限らず他病棟や病院単位でも問題としてよく耳にしていました。

そこで、日々の「学び・体験」を共有する場所を作ることができれば、各課題に対し解決の一助になるのではないかと思い制作しました。
<br>
<br>

## 工夫したところ

1. 利用ターゲットの選定から考えて UI を決定
   - メインターゲットは看護師「20 代・女性」を想定
   - アプリーのカラーは女性向けのサイトや好まれるカラーパレットを調べて選定
   - 統一感を出すために下記の配色でデザインしました。
    ![スクリーンショット 2021-09-06 12 02 23](https://user-images.githubusercontent.com/66349813/132169039-7d157d2e-2ce2-4cb3-9201-86c47c9403a2.png)
     <br>
     <br>
1. markdown ではなく Action Text を導入
   - 日常的に PC を使うという人が少ない
   - markdown の場合、学習コストが掛り敬遠材料になりえる
   - スマホでの利用を想定するとキーボードの切り替えが多く不便
   - 上記のデメリットの対策として直感的に使用できる Action Text を導入しました
     <br>
     <br>
1. 実務でのチーム開発を意識した開発
   - Git, GitHub を用いたソース管理
   - Projects のカンバン方式でタスクを管理
   - issue・ブランチをタスクごとに作成し、作業を進めました
     <br>
     <br>

## 苦労した点

- ActionText

  - 初期状態だと色々なファイルが添付可能なので、画像のみに制限する必要がありこの実装に時間が掛かりました。
  - ActionText のバリテーションに関する情報自体が少なく、Rails 側でどのように処理するのか悩みました。
  - 最終的に JavaScript 側で制御する事で「ファイルタイプ・上限枚数・画像容量の上限」を設ける事ができました。

- ActiveStorage

  - 既存のバリテーションが使用できず、自分で実装する必要がありました。
  - ActionText にどのようにバリテーションを設定するのかでとても苦労しました
  - ActionText でバリテーションにかけて該当した場合、打ち込み直す手間が発生してしまうため、バリテーションが使えませんでした。
    <br>
    <br>

## 機能一覧

|     |           機能           |            Gem             |
| :-: | :----------------------: | :------------------------: |
|  1  |   ログイン・ログアウト   |           devise           |
|  2  | アカウント登録、設定変更 |           devise           |
|  3  |   ユーザーアイコン登録   |       ActiveStorage        |
|  4  |         記事検索         |          ransack           |
|  5  |        記事投稿欄        |         ActionText         |
|  6  |     ページネーション     |          kaminari          |
|  7  |       レスポンシブ       |         Bootstrap          |
|  8  |        テスト実装        | RSpec / Faker / FactoryBot |
|  9  |      フォーマッター      |          Rubocop           |
| 10  |      ゲストログイン      |             x              |
| 11  |    記事投稿機能(CRUD)    |             x              |
| 12  |    いいね機能(非同期)    |             x              |
| 13  |     保存機能(非同期)     |             x              |
| 14  |         タグ機能         |             x              |
| 15  |   記事の公開範囲の設定   |             x              |

## 使用技術

- 言語 : Ruby ( 2.7.2 )
- フレームワーク : Ruby on Rails (6.1.4.1)
- フロントエンド : HTML&CSS/Bootstrap/Javascript
- DB : PostgreSQL
- テスト : RSpec
- インフラ : Heroku(ステージング環境 → 本番環境)+AWS(S3)
- ソースコード管理：GitHub(Projects のカンバン方式で issues を作成しタスクを管理)

## 開発環境

- macOS: Big Sur
- Visual Studio Code
- Figma
- PhotoShop
- Drow.io
- Fontawesome
- SimpleMind Pro
