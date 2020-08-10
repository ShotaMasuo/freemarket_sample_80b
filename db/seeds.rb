lady = Category.create(name: "レディース")

lady_tops = lady.children.create(name: "トップス")
lady_jacket = lady.children.create(name: "ジャケット/アウター")
lady_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"},{name: "その他"}])
lady_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}, {name: "Gジャン/デニムジャケット"},{name: "その他"}])

men = Category.create(name: "メンズ")
men_pants = men.children.create(name: "パンツ")
men_shooes = men.children.create(name: "靴")
men_pants.children.create([{name: "デニム/ジーンズ"}, {name: "ワークパンツ/カーゴパンツ"},{name: "その他"}])
men_shooes.children.create([{name: "スニーカー"}, {name: "サンダル"}, {name: "ブーツ"},{name: "その他"}])