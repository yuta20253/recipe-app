# frozen_string_literal: true

user = User.create!(
  family_name: '長澤',
  given_name: 'まさみ',
  age: 37,
  gender: 0,
  email: 'masami@example.com',
  password: 'password'
)

category_names = %w[和食 洋食 中華 イタリアン エスニック 韓国料理 カレー 粉もの 丼もの スープ デザート その他]
categories = {}

category_names.each do |name|
  categories[name] = RecipeCategory.find_or_create_by!(name: name)
end

recipes_data = [
  {
    title: 'カレーライス',
    description: '家庭の定番。野菜と肉を煮込んだスパイシーなカレー。',
    instructions: "玉ねぎ、じゃがいも、人参を一口大に切る。\n鍋に油を熱し、野菜と肉を炒める。\n水を加えて煮込み、カレールウを加えてさらに煮る。\nご飯にかけて完成。",
    category_name: 'カレー',
    ingredients: {
      '玉ねぎ' => '1個', 'じゃがいも' => '2個', '人参' => '1本',
      '豚肉' => '200g', 'カレールウ' => '1/2箱', 'ご飯' => '適量',
      'サラダ油' => '大さじ1', '水' => '500ml'
    }
  },
  {
    title: 'ナポリタン',
    description: '昭和の洋食の定番。ケチャップで炒める甘酸っぱいスパゲッティ。',
    instructions: "パスタを茹でる。\n玉ねぎとピーマンをスライス、ウインナーを斜め切り。\nフライパンで具材を炒め、ケチャップで味付け。\nパスタを加えて炒める。",
    category_name: '洋食',
    ingredients: {
      'スパゲッティ' => '200g', '玉ねぎ' => '1/2個', 'ピーマン' => '1個',
      'ウインナー' => '3本', 'ケチャップ' => '大さじ4', 'サラダ油' => '大さじ1'
    }
  },
  {
    title: '冷やし中華',
    description: '夏の定番。涼しげな彩りの冷たい中華麺。',
    instructions: "麺を茹でて冷水でしめる。\n具材を細切りにする（きゅうり、ハム、卵焼きなど）。\n麺に具をのせて、たれをかける。",
    category_name: '中華',
    ingredients: {
      '中華麺' => '2玉', 'ハム' => '4枚', '卵' => '2個', 'きゅうり' => '1本',
      'トマト' => '1個', '酢' => '大さじ2', '醤油' => '大さじ2',
      '砂糖' => '小さじ1', 'ごま油' => '小さじ1'
    }
  },
  {
    title: 'お好み焼き',
    description: '具材を混ぜて焼くだけの手軽な粉もの料理。',
    instructions: "キャベツを千切りにする。\n生地の材料と混ぜ、豚バラをのせて焼く。\n両面焼いてソース・マヨネーズをかける。",
    category_name: '粉もの',
    ingredients: {
      'キャベツ' => '1/4個', '卵' => '1個', '小麦粉' => '100g', '水' => '100ml',
      '豚肉' => '100g', 'お好みソース' => '適量', 'マヨネーズ' => '適量'
    }
  },
  {
    title: '照り焼きチキン',
    description: '甘辛いたれが食欲をそそる人気の鶏料理。',
    instructions: "鶏もも肉に下味をつける。\nフライパンで焼き、たれを絡めて照りを出す。",
    category_name: '和食',
    ingredients: {
      '鶏もも肉' => '1枚', '醤油' => '大さじ2', 'みりん' => '大さじ2',
      '砂糖' => '小さじ2', '酒' => '大さじ1'
    }
  },
  {
    title: '味噌汁',
    description: '和食の基本。だしと味噌の香りがほっとする一杯。',
    instructions: "豆腐はさいの目に切り、わかめは水で戻す。\n鍋にだしを沸かし、具材を加える。\n火を止めてから味噌を溶き入れる。",
    category_name: 'スープ',
    ingredients: {
      '豆腐' => '1/2丁', '乾燥わかめ' => '5g', 'だし汁' => '400ml', '味噌' => '大さじ2'
    }
  },
  {
    title: '肉じゃが',
    description: '甘辛く煮込んだ日本の家庭料理の代表格。',
    instructions: "玉ねぎ、じゃがいも、人参を一口大に切る。\n鍋で肉と野菜を炒め、だし・調味料で煮込む。\n煮汁がなくなるまで煮る。",
    category_name: '和食',
    ingredients: {
      'じゃがいも' => '2個', '人参' => '1本', '玉ねぎ' => '1個', '牛肉' => '200g',
      '醤油' => '大さじ3', 'みりん' => '大さじ2', '砂糖' => '大さじ1', 'だし汁' => '300ml'
    }
  },
  {
    title: '親子丼',
    description: '鶏肉と卵を甘辛く煮てご飯にのせた丼料理。',
    instructions: "玉ねぎと鶏肉を切り、鍋で煮る。\n調味料を加えて火が通ったら、溶き卵を回しかける。\nご飯にのせて完成。",
    category_name: '丼もの',
    ingredients: {
      '鶏もも肉' => '150g', '玉ねぎ' => '1/2個', '卵' => '2個', '醤油' => '大さじ2',
      'みりん' => '大さじ2', 'だし汁' => '100ml', 'ご飯' => '1膳'
    }
  },
  {
    title: 'ハンバーグ',
    description: '子どもから大人まで大好きな定番洋食。',
    instructions: "玉ねぎを炒めて冷ます。\n材料をすべて混ぜてこねる。\n形成し、両面焼く。\nソースを作ってかける。",
    category_name: '洋食',
    ingredients: {
      '合挽き肉' => '250g', '玉ねぎ' => '1個', 'パン粉' => '1/2カップ', '卵' => '1個',
      '塩こしょう' => '少々', 'ウスターソース' => '大さじ2', 'ケチャップ' => '大さじ2'
    }
  },
  {
    title: '生姜焼き',
    description: 'しょうがが香る豚肉の甘辛炒め。',
    instructions: "豚肉を調味料に漬け込む。\nフライパンで焼く。\nたれを絡めて照りを出す。",
    category_name: '和食',
    ingredients: {
      '豚ロース肉' => '200g', '醤油' => '大さじ2', 'みりん' => '大さじ1',
      '酒' => '大さじ1', 'おろし生姜' => '小さじ1'
    }
  },
  {
    title: 'オムライス',
    description: 'ケチャップライスを卵で包んだ洋風ご飯。',
    instructions: "鶏肉・玉ねぎを炒め、ご飯とケチャップを加える。\n卵を焼いて包む。\n上にケチャップをかける。",
    category_name: '洋食',
    ingredients: {
      'ご飯' => '1膳', '鶏もも肉' => '100g', '玉ねぎ' => '1/4個', '卵' => '2個',
      'ケチャップ' => '大さじ3', 'サラダ油' => '小さじ1'
    }
  },
  {
    title: '焼きそば',
    description: 'ソースの香ばしい香りが食欲をそそる。',
    instructions: "肉と野菜を炒める。\n麺を加えて炒める。\nソースで味付けして完成。",
    category_name: '粉もの',
    ingredients: {
      '中華麺' => '1玉', '豚肉' => '100g', 'キャベツ' => '2枚', '人参' => '1/3本',
      'ソース' => '大さじ2', 'サラダ油' => '小さじ1'
    }
  }
]

ingredients_by_name = Ingredient.all.index_by(&:name)

recipes_data.each do |data|
  recipe = Recipe.create!(
    user: user,
    title: data[:title],
    description: data[:description],
    instructions: data[:instructions],
    difficulty: Recipe.difficulties.keys.sample,
    cooking_time: rand(10..60),
    total_time: rand(20..90),
    servings: "#{rand(1..4)}人前",
    recipe_category: categories[data[:category_name]]
  )

  created_at = Time.at(rand(Time.new(2023, 1, 1).to_i..(Time.now - 1.day).to_i))
  recipe.update_columns(created_at: created_at, updated_at: created_at)

  data[:ingredients].each do |name, quantity|
    ingredient = ingredients_by_name[name] || Ingredient.create!(name: name)
    RecipeIngredient.create!(recipe: recipe, ingredient: ingredient, quantity: quantity)
  end
end
