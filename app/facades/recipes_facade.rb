class RecipesFacade
  def self.search_recipes(country)
    response = RecipesService.search_recipes(country)
    recipe_array = response[:hits]
    recipe_array.map { |recipe_info| Recipe.new(recipe_info, country) }
  end
end