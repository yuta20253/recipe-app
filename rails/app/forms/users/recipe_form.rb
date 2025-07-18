# frozen_string_literal: true

module Users
  class RecipeForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_reader :recipe
    attr_accessor :image

    attribute :title, :string
    attribute :description, :string
    attribute :cooking_time, :integer
    attribute :total_time, :integer
    attribute :servings, :integer
    attribute :difficulty, :string
    attribute :instructions, default: []
    attribute :ingredient_ids, default: []
    attribute :user_id, :integer
    attribute :recipe_category_id, :integer
    attribute :image

    validates :title, presence: true, length: { maximum: 20 }
    validates :difficulty, presence: true, inclusion: { in: %w[easy medium hard] }

    def initialize(attributes = {}, recipe: nil)
      @recipe = recipe
      attributes = attributes.to_h if attributes.respond_to?(:to_h)
      attributes[:ingredient_ids] = Array(attributes[:ingredient_ids])
      if recipe
        super(default_attributes_from(recipe).merge(attributes))
      else
        super(attributes)
      end
    end

    def save
      return false unless valid?

      Recipe.transaction do
        formatted = format_instructions(instructions)
        if recipe
          recipe.update!(
            title: title,
            description: description,
            cooking_time: cooking_time,
            total_time: total_time,
            servings: servings,
            difficulty: difficulty,
            instructions: formatted,
            ingredient_ids: ingredient_ids.reject(&:blank?),
            user_id: user_id,
            recipe_category_id: recipe_category_id
          )
        else
          @recipe = Recipe.create!(
            title: title,
            description: description,
            cooking_time: cooking_time,
            total_time: total_time,
            servings: servings,
            difficulty: difficulty,
            instructions: formatted,
            ingredient_ids: ingredient_ids.reject(&:blank?),
            user_id: user_id,
            recipe_category_id: recipe_category_id
          )
        end
        @recipe.image.attach(image) if image.present?
      end
      true
    rescue StandardError => e
      errors.add(:base, "保存失敗: #{e.message}")
      false
    end

    def to_model
      @recipe || Recipe.new
    end

    def persist?
      false
    end

    def ingredients
      Ingredient.where(id: ingredient_ids.reject(&:blank?))
    end

    private

    def format_instructions(raw_steps)
      steps = raw_steps.is_a?(Array) ? raw_steps : raw_steps.to_s.lines.map(&:chomp)
      steps.reject(&:blank?).each_with_index.map { |step, i| "#{i + 1}. #{step}" }.join("\n")
    end

    def default_attributes_from(recipe)
      {
        title: recipe.title,
        description: recipe.description,
        cooking_time: recipe.cooking_time,
        total_time: recipe.total_time,
        servings: recipe.servings,
        difficulty: recipe.difficulty,
        instructions: recipe.instructions,
        ingredient_ids: recipe.ingredient_ids,
        recipe_category_id: recipe.recipe_category_id
      }
    end
  end
end
