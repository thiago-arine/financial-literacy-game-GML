function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
    show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_dialog = 0;
    _inst.current_message = 0;
};

function mentor_popup(_messages) {
    if (instance_exists(obj_dialog)) return;
    
    // Usamos profundidade 0 pois o Draw GUI cuidará da prioridade visual
    var _inst = instance_create_depth(0, 0, 0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_dialog = 0;
    _inst.current_message = 0;
    _inst.is_mentor_popup = true; 
}

global.char_colors = {
    "Amigo": c_orange,
    "Mentor": c_aqua,
    "Banco": c_red,
    "Sorveteiro": c_fuchsia,
};

global.dialog_cicero = [{
    kind: "pattern",
    happened: false,
    dialog: [
        { 
            name: "Cícero", 
            msg: "Ei! Compro itens usados. O que você tem aí?", 
            is_question: true, 
            options: ["Vender Chave Inglesa (R$ 7)", "Vender DVD (R$ 10)", "Sair"], 
            option_results: [1, 2, 3], 
            choice: "sell_item_simple", 
            kind: "special", 
            number: 0, 
            is_end: true 
        }
    ]
}];

global.dialog_mentor_no_item = [{
    kind: "pattern",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Espere um pouco! Você não tem esse item no seu inventário para vender.", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Certifique-se de que o item está na sua mochila antes de negociar com o Cícero.", 
            is_question: false, 
            number: -1, 
            is_end: true 
        }
    ]
}];

global.dialog_amigo_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Amigo",
        msg: "Caramba, você achou a chave! Muito obrigado, cara!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Amigo",
        msg: "Vou levar ela agora. Muito obrigado pela ajuda!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_key", kind: "special", result: 1,}
    
        }]
}];

dialog_amigo = [ 
    {   kind: "unique",
        happened: false,
        dialog: [
            { name: "Amigo", msg: "Cara, você não sabe o que aconteceu! O jogo Super Dungeon RPG 3 está com 70% de desconto!", is_question: false, number: 0, is_end: false },
            { 
                name: "Amigo", 
                msg: "Você vai comprar né?", 
                is_question: true, 
                options: ["Óbvio", "Queria muito, mas não vai dar..."], 
                option_results: [1, 2], // 1 = Sim, 2 = Não
                choice: "game_promotion", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },
            // RAMO DO SIM (Resultado 1)
            { 
				name: "Amigo",
				msg: "Boa, sabia que iria comprar!",
				is_question: false,
				number: 1,
				is_end: false
			},
            { name: "Amigo",
				msg: "Amanhã nós jogamos juntos, tchauu.",
				is_question: false,
				number: 1,
				is_end: true
				},
            
            // RAMO DO NÃO (Resultado 2)
            { 
				name: "Amigo",
				msg: "Eita, deixa para lá então...",
				is_question: false,
				number: 2,
				is_end: true
			},
            
            /*// PARTE COMUM - MISSÃO (Número 3)
            // IMPORTANTE: Definimos o option_results do Sim/Não para que, após as falas 1 ou 2, ele busque o 3
            { 
				name: "Amigo",
				msg: "E cara, você pode me ajudar com uma coisa?",
				is_question: false,
				number: 3,
				is_end: false
			},
            { 
				name: "Amigo",
				msg: "Deixei cair a chave da minha casa no seu quintal... Se você achar, pega pra mim! Se não minha mãe vai me matar!",
				is_question: false,
				number: 3,
				is_end: true,
                trigger_event: { name: "start_quest_key", kind: "special", result: 1 }
			}*/
        ]
    },
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [{ name: "Amigo", msg: "Oi, amigo!", is_question: false, number: 0, is_end: true }]
    }
];

global.dialog_mentor_transicao_fase = [{
    kind: "unique",
    happened: false,
    dialog: [
        /*{ 
            name: "Mentor", 
            msg: "Vejo que você juntou R$ 100! Deseja comprar o fone agora? Isso iniciará a próxima fase e missões pendentes podem ser perdidas.", 
            is_question: true, 
            options: ["Sim, comprar fone", "Ainda não"],
            option_results: [1, 2],
            choice: "phase_transition",
            kind: "special",
            number: -0, 
            is_end: false 
        },*/
        { 
            name: "Mentor", 
            msg: "Vejo que você juntou R$ 100! Parabéns!", 
            is_question: false, 
            number: 1, // Resposta "Sim"
            is_end: false,
        },
        { 
            name: "Mentor", 
            msg: "Você conseguiu administrar seus ganhos e gastos corretamente e atingiu a meta a tempo.", 
            is_question: false, 
            number: 1, // Resposta "Sim"
            is_end: false,
        },
        { 
            name: "Mentor", 
            msg: "Este é o fim da nossa jornada. Obrigado por jogar este playtest!", 
            is_question: false, 
            number: 1, // Resposta "Sim"
            is_end: true,
        },
        /*{ 
            name: "Mentor", 
            msg: "Excelente escolha! Com os fones, novas oportunidades de trabalho surgirão. Sua próxima meta é economizar para um celular de R$ 900.", 
            is_question: false, 
            number: 1, // Resposta "Sim"
            is_end: true,
            trigger_event: { name: "start_phase_2", kind: "special", result: 2 } 
        },
        { 
            name: "Mentor", 
            msg: "Tudo bem. Volte quando estiver pronto para avançar.", 
            is_question: false, 
            number: 2, // Resposta "Não"
            is_end: true 
        }*/
    ]
}];

dialog_mentor = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            /*{ 
                name: "Mentor",
                msg: "Bem vindo! Sou seu mentor financeiro.",
                is_question: false,
                number: -1,
                is_end: false
            },
            { 
                name: "Mentor",
                msg: "Nosso objetivo: Construir liberdade financeira...",
                is_question: false,
                number: -1,
                is_end: false
            },
            /*{
                name: "Mentor",
                msg: "Ao longo de sua jornada aparecerão oportunidades...",
                is_question: false,
                number: -1,
                is_end: false
            },*/
            {
                name: "Mentor", 
                msg: "Vamos começar. Qual o seu objetivo financeiro?",
                is_question: true,
                options: ["Fone de Ouvido: R$100,00 em 4 meses"],   //"Celular: R$900,00 em 9 meses", "Formatura: R$1700,00 em 15 meses"]
                option_results: [1], //[1, 2, 3]
                choice: "meta", 
                kind: "special",
                number: -1,
                is_end: false
            },/*
            {
                name: "Mentor",
                msg: "Em todos os meses, no dia 1º, você receberá uma mesada...",
                is_question: false,
                number: -1,
                is_end: false
            }, 
            { 
                name: "Mentor", 
                msg: "ATENÇÃO!!! Você encontrará várias decisões de compra. Na maioria você só terá UMA CHANCE de decidir aceitar ou não!",
                is_question: false,
                number: -1,
                is_end: false
            },
            { 
                name: "Mentor", 
                msg: "E fique esperto com os quizzes supresa!",
                is_question: false,
                number: -1,
                is_end: false
            },*/
            { 
                name: "Mentor", 
                msg: "Clique 'Z' para acessar seu saldo e 'C' para acessar seu celular. Boa sorte!",
                is_question: false,
                number: -1,
                is_end: true
            }
            
        ]
    },
    
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { 
                name: "Mentor",
                msg: "O desconto é sempre maior se você não comprar!",
                is_question: false,
                number: 0,
                is_end: true
            }
        ]
    },
    
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [
            { 
                name: "Mentor",
                msg: "Mantenha seu foco, controle seus gastos e alcance a sua meta!",
                is_question: false,
                number: 0,
                is_end: true
            }
        ]
    }
];

global.dialog_sorveteiro = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Sorveteiro", 
                msg: "Olá! O dia está quente. Aceita um sorvete?", 
                is_question: true, 
                options: ["Casquinha (R$5)", "Copo Médio (R$10)", "Não, obrigado"], 
                option_results: [1, 2, 3], 
                choice: "buy_icecream", 
                kind: "loss", 
                number: 0, 
                is_end: true 
            }
        ]
    }
];

global.goal_tp_block = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Aviso!", 
                msg: "Escolha sua meta com o Mentor antes de sair!", 
                is_question: false, 
                number: 0, 
                is_end: true 
            }
        ]
    }
];

global.dialog_sem_dinheiro = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Banco", 
                msg: "Você não tem saldo suficiente para esta compra...", 
                is_question: false, 
                number: 0, 
                is_end: true 
            }
        ]
    }
];

global.dialog_shopkeeper_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Tadeu",
        msg: "Olha só! Você realmente achou a pipa e ela ainda está inteirinha!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Vou guardá-la, muito obrigado garoto!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Você é um bom menino! Toma aqui um dinheirinho pra você ficar!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Agora, me dê licença que vou procurar uma rabiola nova para essa pipa aqui. Até mais!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_kite", kind: "special", result: 1, reward: 15 }
    }]
}];

global.dialog_shopkeeper = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { 
            name: "Tadeu", 
            msg: "Opa, tudo bem? Estou abrindo a loja agora, desculpa a bagunça.", 
            is_question: false, 
            number: -1, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "Posso ajudar em algo?", 
            is_question: true, 
            options: ["Perguntar sobre decoração de pipa (missão)", "Não, obrigado (sair)"], 
            option_results: [1, 2], 
            choice: "shopkeeper_choice",
            kind: "special", 
            number: 0, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "Ah, eu gosto muito de pipas desde criança. Não só vendo elas na loja, eu também brinco de empinar pipa quando posso.", 
            is_question: false, 
            number: 1, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "Aliás, no outro dia, estava brincando com minha pipa novinha na praça, mas bateu um vento forte e ela caiu lá pra direita do parque depois de uma cerca. Não consigo chegar lá para recuperá-la", 
            is_question: false, 
            number: 1, 
            is_end: false 
            },
            { 
             name: "Tadeu", 
            msg: "Se você estiver passando por lá qualquer dia e conseguir encontrar a pipa, traz ela para mim, por favor? Se você fizesse isso, eu ficaria muito grato!", 
            is_question: false, 
            number: 1, 
            is_end: true,
            trigger_event: { name: "start_quest_kite", kind: "special", result: 1 }
            },
            { 
            name: "Tadeu", 
            msg: "Volte sempre! As coisas já estão praticamente prontas aqui, se já quiser comprar algo.", 
            is_question: false, 
            number: 2, 
            is_end: true 
            },
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        required_event: "",
        dialog: [
            { 
            name: "Tadeu", 
            msg: "Boa tarde! Seja bem vindo à Lojinha do Tadeu!", 
            is_question: false, 
            number: -1, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "O que você deseja?", 
            is_question: true, 
            options: ["Ver o catálogo", "Sair"], 
            option_results: [1, 2], 
            choice: "shopkeeper_choice",
            kind: "special", 
            number: 0, 
            is_end: false 
            },
            { name: "Tadeu", 
            msg: "Aqui está o catálogo", 
            is_question: false, 
            number: 1, is_end: true, 
            trigger_event: { name: "open_shop", kind: "special", result: 1 } 
            },
            { 
            name: "Tadeu", 
            msg: "Volte sempre!", 
            is_question: false, 
            number: 2, 
            is_end: true 
            },
        ]
    }
];

global.dialog_influencer_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Influencer",
        msg: "Olha só quem voltou! E trouxe o fone como eu pedi, eu sei que você me ama.",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Influencer",
        msg: "Pode deixar comigo. E toma uns trocados aqui para comprar uma balinha que hoje eu tô me sentindo caridoso!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_headset", kind: "special", result: 1, reward: 20 }
    }]
}];

global.dialog_influencer = [
  {
    kind: "unique",
    happened: false,
    required_event: "",
    dialog: [
      {
        name: "Influencer",
        msg: "Fala, pessoal! Acabei de comprar o novo 'Tênis Neon 3000'. Se você não tem um desses, você está perdendo a moda!",
        is_question: false,
        number: -1,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "[O que você faz?]",
        is_question: true,
        options: ["Sair", "Ficar encarando o influencer (missão)"],
        option_results: [1, 2],
        choice: "staring_mission",
        kind: "special",
        number: 0,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Isso aí, tchau!",
        is_question: false,
        number: 1,
        is_end: true
      },
      {
        name: "Influencer",
        msg: "...",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "...........",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Tá olhando o quê? Quer uma foto?",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Não? Então vai ver se eu tô la na esquina vai!!------Naa verdadee! Já que você não tá fazendo nada aí parado...",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Você bem que podia pegar meu headset Hi-Tech T570S roxo que eu deixei na minha mansão particular futurista brilhante.",
        is_question: false,
        number: 2,
        is_end: false
      },
    {
        name: "Influencer",
        msg: "Eu preciso desse headset para gravar meu próximo vídeo. Se você pegar pra mim, talvez eu até marque você no próximo story.",
        is_question: false,
        number: 2,
        is_end: true,
        trigger_event: { name: "start_quest_headset", kind: "special", result: 1 }
    }
    ]
  },
  {
    kind: "pattern",
    happened: false,
    required_event: "",
    dialog: [
        {
            name: "Influencer",
            msg: "Ei! Vi que você guardou sua mesada o mês todo... mas esquece isso! ",
            is_question: false,
            number: -1,
            is_end: false 
        }, 
        {
            name: "Influencer",
            msg: "Se você comprar esse 'Tênis Neon 3000' agora, eu te coloco no meu vídeo.",
            is_question: true,
            options: ["Comprar o Tênis (-R$30,00)", "Manter meta", "Verificar se o Tênis é útil"],
            option_results: [1, 2, 3],
            choice: "buy_led_hat",
            kind: "loss",
            number: 0,
            is_end: false 
        }, 
        {
            name: "Influencer",
            msg: "ISSO! O tênis ficou incrível. Olha esse brilho!",
            is_question: false,
            number: 1,
            is_end: true 
        }, 
        {
            name: "Influencer",
            msg: "Sério? Você vai preferir guardar dinheiro? Que tédio...",
            is_question: false,
            number: 2,
            is_end: true 
        }, 
        {
            name: "Influencer",
            msg: "Útil? Cara, é um tênis que brilha! Tchau!",
            is_question: false,
            number: 3,
            is_end: true 
        }
    ]
  }
];

global.dialog_wanderley = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Wanderley", 
                msg: "E aí, campeão!  Vai uma coxinha pra viagem aí? Tá na promoção! só 5 reais", 
                is_question: true, 
                options: ["Comprar (R$ 5,00)", "Tô tentando economizar um pouco, seu Wanderley.", "Hoje não, valeu."], 
                option_results: [1, 2, 3],
                choice: "buy_coxinha", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Wanderley", 
                msg: "Boa! Toma aqui, cuidado pra não sujar a camisa da escola, que sua mãe fica brava. Até amanhã!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Wanderley", 
                msg: "Ah, sei como é que é. Juntar um trocado é difícil mesmo, tudo subindo...", 
                is_question: false, 
                number: 2, 
                is_end: false 
            },
            { 
                name: "Wanderley", 
                msg: "Mas ó, precisando de sustância pra aguentar o caminho até em casa, sabe onde me achar. Juízo aí com esse dinheiro, hein!", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Wanderley", 
                msg: "Sem problemas, chefe! Passa aqui amanhã que deve ter uma leva saindo quentinha. Bom descanso pra você aí!", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    }
    
];

global.dialog_lucas = [
    {   
        kind: "unique",
        happened: false,
        dialog: [
            
            { 
                name: "Lucas", 
                msg: "Cara, você não tem noção! Consegui uma  carta do 'Gato Invisível' ontem. É raríssima!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
			
			{ 
                name: "Lucas", 
                msg: "Faço por R$ 5,00 só porque a gente é parceiro. Eu ia guardar pra mim, mas tô precisando de uma grana pra um jogo novo.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            { 
                name: "Lucas", 
                msg: "Quer comprar?", 
                is_question: true, 
                options: ["Comprar (R$ 5,00)", "R$ 5? É muita grana pra um papel...", "Agora não, Lucas. Valeu!"], 
                option_results: [1, 2, 3], 
                choice: "buy_card", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Lucas", 
                msg: "Valeu! Você não vai se arrepender, olha como ela brilha no sol. Cuida bem dela, hein!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Lucas", 
                msg: "Papel? Isso aqui é item de colecionador, pô! Mas beleza, depois não chora quando ela valorizar e eu não quiser mais vender.", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Lucas", 
                msg: "Tranquilo, sem grilo. Vou ver se o pessoal do outro nono ano tem interesse. Falou!", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Lucas", 
                msg: "E aí, cara!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            },
			
        ]
    }
];

global.dialog_donagraca = [
    {   
        kind: "unique",
        happened: false,
        dialog: [

            { 
                name: "Dona Graça", 
                msg: "Oi, meu filho! Estava aqui arrumando as prateleiras e achei esse ursinho de pelúcia rosa... não é a coisa mais fofa do mundo?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
			
			{ 
                name: "Dona Graça", 
                msg: "Ficaria lindo decorando o seu quarto, não acha?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Se você quiser o ursinho, faço por R$ 8,00 pra você.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Se não quiser, eu vou dar pra minha neta mesmo. É bem a carinha dela esse bichinho.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Vai querer?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "", 
                is_question: true, 
                options: ["Comprar Pelúcia (R$ 8,00)", "É lindo, mas preciso guardar meu dinheiro.", "Agora não, Dona Graça. Obrigado!"], 
                option_results: [1, 2, 3], 
                choice: "buy_bear", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            // RESULTADO 1: Compra efetuada (Obrigatório ser o 1 para gastos)
            { 
                name: "Dona Graça", 
                msg: "Ai, que bom gosto! Ele vai te dar muita sorte, você vai ver. Anda com cuidado, viu!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Dona Graça", 
                msg: "Ah, eu entendo perfeitamente, querido. Está certo em poupar. Você é um bom menino.", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Dona Graça", 
                msg: "Tudo bem, meu anjo. Passa aqui depois pra me dar um oi, mesmo se não for comprar nada! Vai com Deus.", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    {   
        kind: "unique",
        happened: false,
        dialog: [

            { 
                name: "Dona Graça", 
                msg: "Oi, meu filho! Tudo bom?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Pior que a vendinha ainda tá fechada. Vai abrir ainda não.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Também, logo mais chega semana de chuva. Não é nem bom abrir mesmo.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Dona Graça", 
                msg: "Mas não vou te alugar mais não, filho. Vai lá, que se não eu fico o dia todo aqui falando e tu não vai ter tempo de brincar", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Até logo, filho!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            }
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Dona Graça", 
                msg: "Oi, meu filho! A vendinha está fechada nesses dias...", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Volte outro dia. Logo mais abre!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            }
            
        ]
    }
];

global.dialog_luna = [
    {   
        kind: "unique",
        happened: false,
        dialog: [

            { 
                name: "Luna", 
                msg: "Ei, olha só... acabei de terminar mais esse quadro do parque. Essa vista é linda, né?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Estou vendendo essa pintura por R$ 20,00. Você quer comprar?", 
                is_question: true, 
                options: ["Comprar Pintura (R$ 12,00)", "É linda, mas não posso gastar agora.", "Não, valeu."], 
                option_results: [1, 2, 3], 
                choice: "buy_painting", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Valeu demais pelo apoio! Essa aqui é única, viu? Coloca em algum lugar com luz boa que ela transforma o ambiente. Até mais!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Luna", 
                msg: "Entendo perfeitamente. Às vezes o bolso não acompanha a vontade, né? Mas valeu por parar pra apreciar!", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Luna", 
                msg: "Beleza! Bom caminho pra você, garoto. Se mudar de ideia, estarei por aqui até o sol se pôr.", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    
    {   
        kind: "unique",
        happened: false,
        dialog: [

            { 
                name: "Luna", 
                msg: "Oie! Já vendi quase todos os quadros, só sobrou mais um!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Está por R$12,00. Quer comprar? Na próxima vez que vier aqui, não te garanto que ainda vai ter ein!", 
                is_question: true, 
                options: ["Comprar Pintura (R$ 12,00)", "É linda, mas não posso gastar agora.", "Não, valeu."], 
                option_results: [1, 2, 3], 
                choice: "buy_painting", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Valeu demais pelo apoio! Esse aqui é único, viu? Coloca em algum lugar com luz boa que ela transforma o ambiente. Até mais!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Luna", 
                msg: "Entendo. Quem sabe numa próxima com outra paisagem, outra pintura e outras energias.", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Luna", 
                msg: "Que pena... espero que a arte encontre seu coração por outros meios.", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    
    {   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Luna", 
                msg: "Oie! Já vendi todas as minhas pinturas.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Luna", 
                msg: "Mas gora vou focar nas minhas energias interiores buscando inspiração para a próxima pintura.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Luna", 
                msg: "Foi bom falar com você. Até mais!!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
        ]    
    }        
];

global.dialog_mentor_low_balance = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Ei, preste atenção! Seu saldo chegou a menos que 15% de sua meta!", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Seu dinheiro está acabando rápido. Se continuar gastando assim, não vai alacançar sua meta!", 
            is_question: false, 
            number: -1, 
            is_end: true 
        }
    ]
}];

global.dialog_mentor_first_goal_reached = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Parabéns! Você conseguiu guardar R$ 100,00 e agora pode completar a primeira meta de comprar um fone de ouvido!", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Venha falar comigo na casa inicial para comprar seu fone e avançarmos!", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Mentor", 
            msg: "Cuidado para não gastar seu dinheiro antes de comprar o fone! Pense bem antes de qualquer compra.", 
            is_question: false, 
            number: -1, 
            is_end: true
        }
    ]
}];

global.dialog_mentor_statement_tutorial = [
    {
        kind: "unique",
        happened: false,
        dialog: [
            { 
                name: "Mentor", 
                msg: "Você acabou de fazer sua primeira compra! Sua transação foi registrada no extrato!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "O extrato é sua lista de transações. Itens em vermelho são gastos, e verde são ganhos.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "Clique 'Z' para abrir seu extrato. Revise-o sempre para entender se seus hábitos estão te aproximando ou te afastando da meta.", 
                is_question: false, 
                number: -1, 
                is_end: true 
            }
        ]
    }
];

global.dialog_mentor_inventory_tip = [
    {
        kind: "unique",
        happened: false,
        dialog: [
            { 
                name: "Mentor", 
                msg: "Belo achado! Guarde isso com cuidado.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "Pressione 'X' para abrir seu inventário. Lá você pode ver tudo o que coletou.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "Lembre-se: espaço é limitado. Você sempre pode vender os itens que encontrar por aí, contanto que não sejam itens de missão!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            }
        ]
    }
];

global.dialog_mentor_welcome = [
    {
        kind: "unique",
        happened: false,
        dialog: [
            { 
                name: "Mentor", 
                msg: "Olá! Seja bem-vindo à sua jornada financeira.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "Aqui, cada centavo conta. Seu objetivo é aprender a gerenciar seu dinheiro para conquistar seus sonhos.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Mentor", 
                msg: "Acesse seu celular pela tecla ‘C’ e fique de olho no seu painel de metas e no seu saldo. Saber seus objetivos é o primeiro passo!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            }
        ]
    }
];

global.dialog_rocha  = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Rocha", 
            msg: "Opa, pequeno. Tudo bem?", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Rocha", 
            msg: "Será que a lojinha do Tadeu já abriu?", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Rocha", 
            msg: "Do jeito que ele é todo perdido não sei não.", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Rocha", 
            msg: "Vi que agora ele começou a comprar recicláveis e ferramentas. Não sei se vai dar certo isso.", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Rocha", 
            msg: "Ainda mais que na feira ainda deve ter um preço melhor. Mas vamos ver né", 
            is_question: false, 
            number: -1, 
            is_end: true
        }
    ]
},

{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Rocha", 
            msg: "Opa, pequeno. Tudo bem?", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Rocha", 
            msg: "Cuidado para não ser enganado pelas pessoas.", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Rocha", 
            msg: "Todo mundo aqui quer uma fatia do mesmo bolo, mesmo que tenha que roubar a fatia de outro.", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Rocha", 
            msg: "Siga sempre seus sonhos, mas é só com foco e persistência que você vai alcançar eles.", 
            is_question: false, 
            number: -1, 
            is_end: true
        }
    ]
},
{   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Rocha", 
                msg: "Juízo, pequeno!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            },
			
        ]
    }
];

global.dialog_mentor_quiz = [{
    kind: "unique", 
    happened: false,
    dialog: [

        { 
            name: "Mentor", 
            msg: "Para economizar dinheiro no fim do mês, qual é a atitude mais importante?", 
            is_question: true, 
            options: [
                "Gastar tudo no crédito", 
                "Esconder dinheiro embaixo do colchão", 
                "Anotar gastos e criar um orçamento", // <-- A Certa
            ], 
            option_results: [2, 2, 1], // 1 = Ramo Certo, 2 = Ramo Errado
            choice: "quiz_1", 
            kind: "special", 
            number: 0, 
            is_end: false 
        },
        
        { 
            name: "Mentor", 
            msg: "Resposta correta! Você vai receber uma recompensa de R$10,00 por acertar o quiz!", 
            is_question: false, 
            number: 1, 
            is_end: true,
            // A recompensa é dada automaticamente através do atributo 'reward'
            trigger_event: { name: "quiz_1_done", kind: "special", result: 1, reward: 10 } 
        },

        { 
            name: "Mentor", 
            msg: "Hmm, não tenho certeza se isso é uma boa ideia... Tente pensar de outra forma.", 
            is_question: false, 
            number: 2, 
            is_end: false, 
            jump_to: 0 // <--- A MÁGICA: Volta para a frase no Índice 0 (A Pergunta)
        }
    ]
}];

global.dialog_mentor_quiz_2 = [{
    kind: "unique", 
    happened: false,
    dialog: [

        { 
            name: "Mentor", 
            msg: "Qual destes é um exemplo de 'Gasto Variável' (aquele que muda todo mês)?", 
            is_question: true, 
            options: [
                "A mensalidade da internet.", 
                "Gastos com pizza no final de semana.",  // certa
                "A parcela fixa do seu curso.", 

            ], 
            option_results: [2, 1, 2], // 1 = Ramo Certo, 2 = Ramo Errado
            choice: "quiz_2", 
            kind: "special", 
            number: 0, 
            is_end: false 
        },
        
        { 
            name: "Mentor", 
            msg: "Resposta correta! Você vai receber uma recompensa de R$10,00 por acertar o quiz!", 
            is_question: false, 
            number: 1, 
            is_end: true,
            // A recompensa é dada automaticamente através do atributo 'reward'
            trigger_event: { name: "quiz_2_done", kind: "special", result: 1, reward: 10 } 
        },

        { 
            name: "Mentor", 
            msg: "Hmm, não tenho certeza se isso é uma boa ideia... Tente pensar de outra forma.", 
            is_question: false, 
            number: 2, 
            is_end: false, 
            jump_to: 0 
        }
    ]
}];


global.dialog_mentor_quiz_3 = [{
    kind: "unique", 
    happened: false,
    dialog: [

        { 
            name: "Mentor", 
            msg: "Se o seu saldo acabando no meio do mês, qual a melhor estratégia?", 
            is_question: true, 
            options: [
                "Pegar um empréstimo com juros altos.", 
                "Esperar o próximo mês e não fazer nada.",  // certa
                "Buscar uma forma de renda extra ou vender algo que não usa.", 

            ], 
            option_results: [2, 1, 2], // 1 = Ramo Certo, 2 = Ramo Errado
            choice: "quiz_3", 
            kind: "special", 
            number: 0, 
            is_end: false 
        },
        
        { 
            name: "Mentor", 
            msg: "Resposta correta! Você vai receber uma recompensa de R$10,00 por acertar o quiz!", 
            is_question: false, 
            number: 1, 
            is_end: true,
            // A recompensa é dada automaticamente através do atributo 'reward'
            trigger_event: { name: "quiz_3_done", kind: "special", result: 1, reward: 10 } 
        },

        { 
            name: "Mentor", 
            msg: "Hmm, não tenho certeza se isso é uma boa ideia... Tente pensar de outra forma.", 
            is_question: false, 
            number: 2, 
            is_end: false, 
            jump_to: 0 // 
        }
    ]
}];

global.dialog_mentor_quiz_4 = [{
    kind: "unique", 
    happened: false,
    dialog: [

        { 
            name: "Mentor", 
            msg: "Qual a melhor estratégia para gerenciar sua mesada todos os meses?", 
            is_question: true, 
            options: [
                "Dividir o dinheiro entre necessidades, desejos e poupança.", //certa
                "Gastar tudo na primeira semana e esperar a próxima mesada.",  
                "Guardar tudo e nunca gastar com nada que eu gosto.", 

            ], 
            option_results: [1, 2, 2], // 1 = Ramo Certo, 2 = Ramo Errado
            choice: "quiz_4", 
            kind: "special", 
            number: 0, 
            is_end: false 
        },
        
        { 
            name: "Mentor", 
            msg: "Resposta correta! Você vai receber uma recompensa de R$10,00 por acertar o quiz!", 
            is_question: false, 
            number: 1, 
            is_end: true,
            // A recompensa é dada automaticamente através do atributo 'reward'
            trigger_event: { name: "quiz_4_done", kind: "special", result: 1, reward: 10 } 
        },

        { 
            name: "Mentor", 
            msg: "Hmm, não tenho certeza se isso é uma boa ideia... Tente pensar de outra forma.", 
            is_question: false, 
            number: 2, 
            is_end: false, 
            jump_to: 0 // 
        }
    ]
}];

global.dialog_mentor_game_over = [{
    kind: "unique", 
    happened: false,
    dialog: [
        
        { 
            name: "Mentor", 
            msg: "O tempo acabou! Você não conseguiu economizar os R$ 100,00 a tempo...", 
            is_question: false, 
            number: -1, 
            is_end: false,
            
        },
        { 
            name: "Mentor", 
            msg: "Que esta tentativa fique de experiência e te ajude a se planejar melhor em uma próxima vez!", 
            is_question: false, 
            number: -1, 
            is_end: false,
            
        },

        { 
            name: "Mentor", 
            msg: "Este é o fim da nossa jornada. Obrigado por jogar este playtest!", 
            is_question: false, 
            number: -1, 
            is_end: true, 
            jump_to: 0 
        }
    ]
}];