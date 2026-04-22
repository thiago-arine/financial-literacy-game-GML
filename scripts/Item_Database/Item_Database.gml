function get_item_data(_item_id) {
    switch(_item_id) {
        case "key":
            return { 
                name: "Chave", 
                sprite: spr_item_key, 
                sell_price: 5, 
                type: "special" 
            };
            
        case "headset":
            return { 
                name: "Fone de Ouvido", 
                sprite: spr_item_headset, 
                sell_price: 30, 
                type: "special" 
            };
            
        case "screwdriver":
            return { 
                name: "Chave Inglesa", 
                sprite: spr_item_screwdriver, 
                sell_price: 5, 
                type: "collectible" 
            };
        case "kite":
            return { 
                name: "Pipa", 
                sprite: spr_item_kite, 
                sell_price: 6, 
                type: "special" 
            };    
        case "bottle":
            return { 
                name: "Garrafa", 
                sprite: spr_item_bottle, 
                sell_price: 3, 
                type: "collectible" 
            };
        case "flashlight":
            return { 
                name: "Lanterna Quebrada", 
                sprite: spr_item_flashlight, 
                sell_price: 7, 
                type: "collectible" 
            };    
        case "dvd":
            return { 
                name: "DVD", 
                sprite: spr_item_flashlight, 
                sell_price: 2, 
                type: "collectible" 
            };
        case "kiteshop":
            return { 
                name: "Pipa Roxa", 
                sprite: spr_item_kite_shop, 
                sell_price: 4, 
                type: "collectible" 
            };
                        
        case "bear":
            return { 
                name: "Ursinho de Pelúcia", 
                sprite: spr_item_bear, 
                sell_price: 0, 
                type: "special" 
            };
        case "card":
            return { 
                name: "Card do Gato Invisível", 
                sprite: spr_item_card, 
                sell_price: 0, 
                type: "special" 
            };    
        case "coxinha":
            return { 
                name: "Coxinha", 
                sprite: spr_item_coxinha, 
                sell_price: 0, 
                type: "special" 
            };
        case "gamedisc":
            return { 
                name: "Super Dungeon RPG 3", 
                sprite: spr_item_gamedisc, 
                sell_price: 0, 
                type: "special" 
            };   
        case "icecream":
            return { 
                name: "Sorvete de Casquinha", 
                sprite: spr_item_icecream, 
                sell_price: 0, 
                type: "special" 
            }; 
        case "painting":
            return { 
                name: "Pintura da Praça", 
                sprite: spr_item_painting, 
                sell_price: 0, 
                type: "special" 
            };
        case "sneakers":
            return { 
                name: "Tênis Neon 3000", 
                sprite: spr_item_sneakers, 
                sell_price: 0, 
                type: "special" 
            };        
            
        default:
            return { name: "Item", sprite: spr_icon_goal, sell_price: 2, type: "special" };
    }
}