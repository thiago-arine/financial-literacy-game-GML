function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
        show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages  =_messages;
	_inst.current_dialog = 0
    _inst.current_message = 0;
};

char_colors = {
    "Amigo": c_white,
    "Mentor": c_white,
};

dialog_npc = [
	{	kind: "unique",
		happened: false,
		required_event : "",
		dialog:
		[{
	        name: "Amigo",
	        msg: "Cara, você não sabe o que aconteceu! Baldur's Gate 3 está com 70% de desconto!",
			is_question: false,
			number: 0,
			is_end: false,
	    },
	    {
	        name: "Amigo",
	        msg: "Você vai comprar né?",
			is_question: true,
			options: ["Óbvio", "Queria muito, mas não vai dar..."],
			option_results: [1, 2],
			choice: "game_promotion",
			number: 0,
			is_end: false
	    },
		{
			name: "Amigo",
	        msg: "Boa, sabia que iria comprar.",
			is_question: false,
			number: 1,
			is_end: false
		},
		{
			name: "Amigo",
	        msg: "Amanhã nós jogamos juntos, tchauu.",
			is_question: false,
			number: 1,
			is_end: true
		},
		{
			name: "Amigo",
	        msg: "Eita, deixa para lá então...",
			is_question: false,
			number: 2,
			is_end: true
		}]
	},
	{
		kind: "pattern",
		happened: false,
		required_event : "",
		dialog: [{
			name: "Amigo",
	        msg: "Oi, amigo",
			is_question: false,
			number: 0,
			is_end: true
		}]
	}]

dialog_mentor = [{	
		kind: "unique",
		happened: false,
		required_event : "",
		dialog:
		[{
	        name: "Mentor",
	        msg: "Bem vindo! Sou seu mentor financeiro.",
			is_question: false,
			number: -1,
			is_end: false
	    },
	    {
	        name: "Mentor",
	        msg: "Nossa meta: Construir liberdade financeira. Você aprenderá a investir e a diferença entre necessidade e desejo. A partir de agora cada escolha é sua.",
			is_question: false,
			number: -1,
			is_end: false
	    },
	    {
	        name: "Mentor",
	        msg: "Ao longo de sua jornada aparecerão oportunidades, além disso, o influenciador digital vai tentar te convencer a seguir por outro caminho.",
			is_question: false,
			number: -1,
			is_end: false
	    },
	    {
	        name: "Mentor",
	        msg: "Vamos começar. Qual é o seu objetivo financeiro?",
			is_question: true,
			options: ["Celular: R$700,00 em 3 meses", "Formatura: R$1500,00 em 6 meses", "Intercâmbio: R$4000,00 em 12 meses"],
			option_results: [1, 2, 3],
			choice: "meta",
			number: -1,
			is_end: false
	    },
		{
			name: "Mentor",
			msg: "Ótimo! Agora que já definiu a sua meta, vamos ao que interessa: como cumpri-la.",
			is_question: false,
			number: -1,
			is_end: false
		},
		{
			name: "Mentor",
			msg: "Em todos os meses, no dia 1º, você receberá uma mesada de R$100,00 de seus pais. Além disso, você pode procurar por fontes de renda alternativas, mesmo sendo criança.",
			is_question: false,
			number: -1,
			is_end: false
		}, 
		{
			name: "Mentor",
			msg:  "E lembre-se, ganhar não é tudo, você também deve controlar seus gastos durante sua jornada!",
			is_question: false,
			number: -1,
			is_end: false
		}]
		},
		{
		kind: "pattern",
		happened: false,
		required_event : "",
		dialog: [{
			name: "Mentor",
	        msg: "Mantenha seu foco, controle seus gastos e alcance a sua meta!",
			is_question: false,
			number: 0,
			is_end: true
		}]
		}];