function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
    show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_dialog = 0;
    _inst.current_message = 0;
};

global.char_colors = {
    "Amigo": c_orange,
    "Mentor": c_aqua,
    "Banco": c_red,
    "Sorveteiro": c_fuchsia,
};

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
        trigger_event: { name: "quest_key", kind: "special", result: 1 }
    }]
}];

dialog_amigo = [ 
    {   kind: "unique",
        happened: false,
        dialog: [
            { name: "Amigo", msg: "Cara, você não sabe o que aconteceu! Baldur's Gate 3 está com 70% de desconto!", is_question: false, number: 0, is_end: false },
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
            { name: "Amigo", msg: "Boa, sabia que iria comprar!", is_question: false, number: 1, is_end: false },
            { name: "Amigo", msg: "Amanhã nós jogamos juntos, tchauu.", is_question: false, number: 1, is_end: false },
            
            // RAMO DO NÃO (Resultado 2)
            { name: "Amigo", msg: "Eita, deixa para lá então...", is_question: false, number: 2, is_end: false },
            
            // PARTE COMUM - MISSÃO (Número 3)
            // IMPORTANTE: Definimos o option_results do Sim/Não para que, após as falas 1 ou 2, ele busque o 3
            { name: "Amigo", msg: "E cara, você pode me ajudar com uma coisa?", is_question: false, number: 3, is_end: false },
            { name: "Amigo", msg: "Deixei cair a chave da minha casa no seu quintal... Se você achar, pega pra mim! Se não minha mãe vai me matar!", is_question: false, number: 3, is_end: true }
        ]
    },
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [{ name: "Amigo", msg: "Oi, amigo!", is_question: false, number: 0, is_end: true }]
    }
];

dialog_mentor = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { name: "Mentor", msg: "Bem vindo! Sou seu mentor financeiro.", is_question: false, number: -1, is_end: false },
            { name: "Mentor", msg: "Nossa meta: Construir liberdade financeira...", is_question: false, number: -1, is_end: false },
            { name: "Mentor", msg: "Ao longo de sua jornada aparecerão oportunidades...", is_question: false, number: -1, is_end: false },
            { name: "Mentor", msg: "Vamos começar. Qual é o seu objetivo financeiro?", is_question: true, options: ["Fone de Ouvido: R$100,00 em 4 meses", "Celular: R$900,00 em 9 meses", "Formatura: R$1700,00 em 15 meses"], option_results: [1, 2, 3], choice: "meta", kind: "special", number: -1, is_end: false },
            { name: "Mentor", msg: "Ótimo! Agora que já definiu a sua meta...", is_question: false, number: -1, is_end: false },
            { name: "Mentor", msg: "Em todos os meses, no dia 1º, você receberá uma mesada...", is_question: false, number: -1, is_end: false }, 
            { name: "Mentor", msg: "E lembre-se, ganhar não é tudo, você também deve controlar seus gastos! Pressione 'E'...", is_question: false, number: -1, is_end: true }
        ]
    },
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [{ name: "Mentor", msg: "Mantenha seu foco, controle seus gastos e alcance a sua meta!", is_question: false, number: 0, is_end: true }]
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

global.dialog_shopkeeper = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { name: "Tadeu", msg: "Boa tarde! Seja bem vindo à Lojinha do Tadeu!", is_question: false, number: -1, is_end: false },
            { name: "Tadeu", msg: "O que você deseja?", is_question: true, options: ["Ver o catálogo","Perguntar sobre decoração de pipa (missão)", "Sair"], option_results: [1, 2, 3], choice: "shopkeeper_choice",kind: "special", number: 0, is_end: false },
            { name: "Tadeu", msg: "Aqui está o catálogo", is_question: false, number: 1, is_end: true, trigger_event: { name: "open_shop", kind: "special", result: 1 } },
            { name: "Tadeu", msg: "Ah, eu gosto muito de pipas desde criança. Não só vendo elas na loja, eu também brinco de empinar pipa quando posso.", is_question: false, number: 2, is_end: false },
            { name: "Tadeu", msg: "Aliás, no outro dia, estava brincando com minha pipa novinha na praça, mas bateu um vento forte e ela caiu lá pra direita do parque depois de uma cerca. Não consigo chegar lá para recuperá-la", is_question: false, number: 2, is_end: false },
            { name: "Tadeu", msg: "Se você estiver passando por lá qualquer dia e conseguir encontrar a pipa, traz ela para mim, por favor? Se você fizesse isso, eu ficaria muito grato!", is_question: false, number: 2, is_end: true },
            { name: "Tadeu", msg: "Volte sempre!", is_question: false, number: 3, is_end: true },
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Vendedor", 
                msg: "Boa tarde! Seja bem vindo à Lojinha do Tadeu!", 
                is_question: false, 
                number: -1, 
                is_end: false
            }
        ]
    }
];

global.dialog_influencer_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Influencer",
        msg: "Caramba, você achou o fone! Muito obrigado, cara!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Influencer",
        msg: "Vou levar ela agora. Muito obrigado pela ajuda!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_headset", kind: "special", result: 1 }
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
        msg: "Você bem que podia pegar meu fone de ouvido Hi-Tech T570S que eu deixei na minha mansão particular futurista brilhante.",
        is_question: false,
        number: 2,
        is_end: false
      },
    {
        name: "Influencer",
        msg: "Eu preciso desse fone para gravar meu próximo vídeo. Se você pegar pra mim, talvez eu até marque você no próximo story.",
        is_question: false,
        number: 2,
        is_end: true
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
            msg: "Se você comprar esse 'Boné de LED' agora, eu te coloco no meu vídeo.",
            is_question: true,
            options: ["Comprar o Boné (-R$50,00)", "Manter meta", "Verificar se o boné é útil"],
            option_results: [1, 2, 3],
            choice: "buy_led_hat",
            kind: "loss",
            number: 0,
            is_end: false 
        }, 
        {
            name: "Influencer",
            msg: "ISSO! O boné ficou incrível. Olha esse brilho!",
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
            msg: "Útil? Cara, é um boné que brilha! Tchau!",
            is_question: false,
            number: 3,
            is_end: true 
        }
    ]
  }
];