# Translate some inputs from web scraping from Portuguese to English

def translate(input)
  # Translate Code Here
  if input == "Vestuário"
    "Clothing"
  elsif input == "Livros"
    "Books"
  elsif input == "Decoração"
    "Decoration"
  elsif input == "Cozinha"
    "Kitchen"
  elsif input == "Acessórios"
    "Accessories"
  elsif input == "Colecionáveis"
    "Colectibles"
  elsif input == "Camisetas"
    "Shirts"
  elsif input == "Bonés"
    "Hats"
  elsif input == "Calçados"
    "Shoes"
  elsif input == "Colares"
    "Necklaces"
  elsif input == "Máscaras de Dormir"
    "Masks - Sleeping"
  elsif input == "Máscaras Nerd de Tecido"
    "Masks - Nerd Clothing"
  elsif input == "Máscara Preta"
    "Masks - Black"
  elsif input == "Meias"
    "Socks"
  elsif input == "Moletons"
    "Hoodies"
  elsif input == "Apocalipse Zumbi"
    "Zombies"
  elsif input == "Aventura"
    "Adventure"
  elsif input == "Contos"
    "Tales"
  elsif input == "Crônicas"
    "Chronicles"
  elsif input == "Ficção Científica"
    "Science Fiction"
  elsif input == "Guerra"
    "War"
  elsif input == "xx"
    "xx"
  elsif input == ""
    ""
  else
    input
  end
end

# Feito: Vestuario Livros (e subcategorias)
# Falta: Decoracao, cozinha, acessorios, colecionaveis, kits
# Falta: Todas as marcas
