# 📜 The Dining Philosophers Problem / 食事する哲学者の問題

## ❓ Problem / 問題

+ 哲学者の間には 1 本ずつフォークが置かれている。
+ 各哲学者は以下の行動をとる。
  + thinking 状態：思考にふけっている
  + hungry 状態：空腹になると、まず右のフォークをとってから、左のフォークをとる。この順番で両方のフォークをとると eating 状態になる。
  + eating 状態：食事中。食事が終わると thinking 状態に戻る。
+ 哲学者は 5 人いるとする。

## 😵 Deadlock / デッドロック

+ デッドロックとは、2つ以上のプロセスが互いの処理終了を待ち、結果としてどの処理も先に進めなくなること。
+ デッドロックの回避策
  + 哲学者が右のフォークを取る。
  + 左側のフォークが既に取られていた場合、右のフォークを置き、1. へ。<br> 取られていない場合、左のフォークを取る。
  + 哲学者は食事する。
+ 上記の回避策では、ライブロックの回避はできない。
+ ライブロックとは、全てのプロセスがお互いにリソースを譲り合い、処理が止まってしまうこと。
  + 全ての哲学者が右のフォークを取ると、左のフォークが取れないため、右のフォークを置く。
  + この動作が永遠と続く可能性がある。

## 😱 Progressive / 進行性

+ 進行性とは、特定の状態に無限に訪れること。
+ 進行性を成立させる手法 (Arbitrator Solutionというらしい)
  + 哲学者の食事の管理を行う管理者を用意する。
  + 管理者は哲学者の食事要請をキューに格納し、順番に一人ずつ哲学者に食事をさせる。

## 🦄 Source code / ソースコード

+ [元のコード](./code/dining_philosophers_v1.pml)
+ [デッドロックを回避するコード](./code/dining_philosophers_v2.pml)
+ [進行性が成立するコード](./code/dining_philosophers_v3.pml)

## 🐪 Report / レポート

+ [レポート](./build/index.pdf)

## 🎁 References / 参考文献

+ [設計モデル検証（応用編）―第一回:並行分散システムの設計の難しさ―](http://files.topse.jp/pdf/sample/mc2_index.pdf)
+ [SPINによるモデル検査(1)](http://swest.toppers.jp/SWEST10/minutes/S2-a-material-nonaka.pdf)
+ [Mini Project: Dining Philosophers](https://www.palfrader.org/research/misc/2010-dining-philosophers.pdf)

## 🍋 License / ライセンス

Copyright (c) 2020-2022 k5-mot All Rights Reserved.

"k5-mot/The-Dining-Philosophers-Problem" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
