import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIconCategoria(String codIcone) {
  return categoriesIcons.firstWhere(
    (e) => e['cod'] == codIcone,
    orElse: () => {"icon": FontAwesomeIcons.angleDoubleRight },
  )['icon'];
}

List categoriesIcons = [
  // {
  //   "cod": "00",
  //   "descricao": "Sem Icone",
  //   "icon": null,
  // },
  {
    "cod": "01",
    "descricao": "Drinks",
    "icon": FontAwesomeIcons.wineBottle,
  },
  // {
  //   "cod": "02",
  //   "descricao": "Miscellaneous",
  //   "icon": FontAwesomeIcons.cannabis
  // },
  {
    "cod": "03",
    "descricao": "Bolo",
    "icon": FontAwesomeIcons.birthdayCake,
  },
  {
    "cod": "04",
    "descricao": "Pizza",
    "icon": FontAwesomeIcons.pizzaSlice,
  },
  {
    "cod": "05",
    "descricao": "Meals",
    "icon": FontAwesomeIcons.breadSlice,
  },
  {
    "cod": "06",
    "descricao": "Apple",
    "icon": FontAwesomeIcons.appleAlt,
  },
  {
    "cod": "07",
    "descricao": "Cheese",
    "icon": FontAwesomeIcons.cheese,
  },
  {
    "cod": "08",
    "descricao": "Cookie",
    "icon": FontAwesomeIcons.cookie,
  },
  {
    "cod": "09",
    "descricao": "Doces",
    "icon": FontAwesomeIcons.candyCane,
  },
  {
    "cod": "10",
    "descricao": "Ovo",
    "icon": FontAwesomeIcons.egg,
  },
  {
    "cod": "11",
    "descricao": "Carnes",
    "icon": FontAwesomeIcons.drumstickBite,
  },
  {
    "cod": "12",
    "descricao": "Peixe",
    "icon": FontAwesomeIcons.fish,
  },
  {
    "cod": "13",
    "descricao": "Cookie",
    "icon": FontAwesomeIcons.hamburger,
  },
  {
    "cod": "14",
    "descricao": "HotDog",
    "icon": FontAwesomeIcons.hotdog,
  },
  {
    "cod": "15",
    "descricao": "Sorvete",
    "icon": FontAwesomeIcons.iceCream,
  },
  {
    "cod": "16",
    "descricao": "Lemon",
    "icon": FontAwesomeIcons.lemon,
  },
  {
    "cod": "17",
    "descricao": "PepperHot",
    "icon": FontAwesomeIcons.pepperHot,
  },
  {
    "cod": "18",
    "descricao": "Verde",
    "icon": FontAwesomeIcons.seedling,
  },
  {
    "cod": "19",
    "descricao": "Comida",
    "icon": FontAwesomeIcons.stroopwafel,
  },
  {
    "cod": "20",
    "descricao": "Folha",
    "icon": FontAwesomeIcons.leaf,
  },
  {
    "cod": "21",
    "descricao": "Utensílios",
    "icon": FontAwesomeIcons.utensils,
  },
  {
    "cod": "22",
    "descricao": "Taça",
    "icon": FontAwesomeIcons.wineGlass,
  },
  {
    "cod": "27",
    "descricao": "Taça2",
    "icon": FontAwesomeIcons.glassMartiniAlt,
  },
  {
    "cod": "28",
    "descricao": "Whiskey",
    "icon": FontAwesomeIcons.glassWhiskey,
  },
  {
    "cod": "23",
    "descricao": "Tag",
    "icon": FontAwesomeIcons.tag,
  },
  {
    "cod": "24",
    "descricao": "award",
    "icon": FontAwesomeIcons.award,
  },
  {
    "cod": "25",
    "descricao": "Up",
    "icon": FontAwesomeIcons.thumbsUp,
  },
  {
    "cod": "26",
    "descricao": "Ellipsis-h",
    "icon": FontAwesomeIcons.ellipsisH,
  },
  {
    "cod": "29",
    "descricao": "Lista",
    "icon": FontAwesomeIcons.listOl,
  },
  {
    "cod": "30",
    "descricao": "Lista",
    "icon": FontAwesomeIcons.listAlt,
  },
  {
    "cod": "31",
    "descricao": "Lista",
    "icon": FontAwesomeIcons.list,
  },
  {
    "cod": "32",
    "descricao": "Lista",
    "icon": FontAwesomeIcons.thList,
  },
  {
    "cod": "33",
    "descricao": "Lampada",
    "icon": FontAwesomeIcons.lightbulb,
  },
  {
    "cod": "34",
    "descricao": "Shoes",
    "icon": FontAwesomeIcons.shoePrints,
  },
  {
    "cod": "35",
    "descricao": "Meias",
    "icon": FontAwesomeIcons.socks,
  },
  {
    "cod": "36",
    "descricao": "TShirt",
    "icon": FontAwesomeIcons.tshirt,
  },
  {
    "cod": "37",
    "descricao": "Tie",
    "icon": FontAwesomeIcons.userTie,
  },
  {
    "cod": "38",
    "descricao": "Presentes",
    "icon": FontAwesomeIcons.gifts,
  },
  {
    "cod": "38A",
    "descricao": "Presente",
    "icon": FontAwesomeIcons.gift,
  },
  {
    "cod": "39",
    "descricao": "Coração",
    "icon": FontAwesomeIcons.heart,
  },
  {
    "cod": "40",
    "descricao": "Star",
    "icon": FontAwesomeIcons.star,
  },
  {
    "cod": "41",
    "descricao": "Bookmark",
    "icon": FontAwesomeIcons.bookmark,
  },
];
