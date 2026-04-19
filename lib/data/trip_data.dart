import 'package:flutter/material.dart';
import '../models/attraction.dart';
import '../models/day.dart';
import '../models/question.dart';

const _westminster = Attraction(
  id: 'westminster',
  name: 'Westminster & Big Ben',
  emoji: '🕰️',
  color: Color(0xFF1A3A6B),
  description: 'O icónico relógio de Londres e o Parlamento Britânico junto ao Tamisa.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Elizabeth_Tower,_London.jpg',
  questions: [
    Question(
      text: '"Big Ben" é uma alcunha. A que se refere especificamente?',
      options: ['Ao sino grande dentro da torre', 'À face do relógio', 'A toda a torre', 'À ponte lá em baixo'],
      correctIndex: 0,
      funFact: 'O Big Ben é o nome do sino principal. Pesa 13,5 toneladas — quase o peso de dois elefantes!',
    ),
    Question(
      text: 'Qual é o nome oficial da torre onde fica o Big Ben?',
      options: ['Torre Elizabeth', 'Torre Victoria', 'Torre Westminster', 'Torre Real'],
      correctIndex: 0,
      funFact: 'Foi renomeada Torre Elizabeth em 2012 para celebrar o Jubileu de Diamante da Rainha Elizabeth II.',
    ),
    Question(
      text: 'Em que ano o Big Ben tocou pela primeira vez?',
      options: ['1859', '1900', '1789', '1945'],
      correctIndex: 0,
      funFact: 'O Big Ben tocou pela primeira vez a 11 de julho de 1859. Já tem mais de 165 anos!',
    ),
    Question(
      text: 'Quantos degraus tens de subir para chegar ao topo da Torre Elizabeth?',
      options: ['334 degraus', '100 degraus', '500 degraus', '50 degraus'],
      correctIndex: 0,
      funFact: 'São 334 degraus sem elevador! Só funcionários e convidados especiais podem subir.',
    ),
    Question(
      text: 'Qual a altura da Torre Elizabeth?',
      options: ['96 metros', '50 metros', '150 metros', '200 metros'],
      correctIndex: 0,
      funFact: 'Com 96 metros, é uma das torres de relógio mais altas do mundo.',
    ),
    Question(
      text: 'O Palácio de Westminster é também conhecido como:',
      options: ['Casas do Parlamento', 'Palácio Real', 'Buckingham Norte', 'Downing Palace'],
      correctIndex: 0,
      funFact: 'O Parlamento Britânico reúne-se aqui desde o século XIII. É um dos mais antigos do mundo!',
    ),
    Question(
      text: 'Qual a cor da Westminster Bridge?',
      options: ['Verde', 'Vermelho', 'Azul', 'Amarelo'],
      correctIndex: 0,
      funFact: 'A cor verde corresponde às cadeiras da Câmara dos Comuns. A ponte de cima é toda verde!',
    ),
    Question(
      text: 'Qual é o rio que corre por baixo da Westminster Bridge?',
      options: ['Rio Tamisa', 'Rio Severn', 'Rio Avon', 'Rio Thames North'],
      correctIndex: 0,
      funFact: 'O Tamisa tem 346 km de comprimento. Os romanos fundaram Londres nas suas margens há 2000 anos!',
    ),
    Question(
      text: 'O Big Ben esteve em silêncio para obras. Em que ano regressou a tocar normalmente?',
      options: ['2022', '2015', '2019', '2020'],
      correctIndex: 0,
      funFact: 'As obras de restauro custaram mais de 80 milhões de libras. Valeu a pena!',
    ),
    Question(
      text: 'Quantas faces tem o relógio do Big Ben?',
      options: ['4 faces', '1 face', '8 faces', '6 faces'],
      correctIndex: 0,
      funFact: 'Cada face tem 7 metros de diâmetro. Os ponteiros têm 4,2 metros de comprimento!',
    ),
  ],
);

const _trafalgar = Attraction(
  id: 'trafalgar',
  name: 'Trafalgar Square & Piccadilly',
  emoji: '🦁',
  color: Color(0xFF1B4F4E),
  description: 'O coração de Londres com leões de bronze, luzes e arte.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Trafalgar_Square,_London_2_-_Sept_2007.jpg',
  questions: [
    Question(
      text: 'A quem é dedicado o monumento central da Trafalgar Square?',
      options: ['Almirante Nelson', 'Rei Jorge III', 'Churchill', 'Wellington'],
      correctIndex: 0,
      funFact: 'O Almirante Nelson venceu a Batalha de Trafalgar em 1805, mas morreu durante o combate.',
    ),
    Question(
      text: 'Quantos leões de bronze guardam a base da Coluna de Nelson?',
      options: ['4 leões', '2 leões', '6 leões', '1 leão'],
      correctIndex: 0,
      funFact: 'Os quatro leões de bronze foram adicionados em 1867, 13 anos depois da coluna!',
    ),
    Question(
      text: 'Quantos metros tem a Coluna de Nelson na Trafalgar Square?',
      options: ['52 metros', '100 metros', '25 metros', '200 metros'],
      correctIndex: 0,
      funFact: 'No topo da coluna há uma estátua de Nelson com 5,5 metros. Lá de baixo parece pequenina!',
    ),
    Question(
      text: 'O que representa a famosa estátua na Piccadilly Circus?',
      options: ['O Anjo da Caridade (chamado Eros)', 'Um soldado romano', 'O Rei Carlos', 'Uma rainha'],
      correctIndex: 0,
      funFact: 'A estátua chama-se oficialmente "Anjo da Caridade Cristã" mas toda a gente diz Eros. Tem desde 1893!',
    ),
    Question(
      text: 'O que era originalmente o Covent Garden?',
      options: ['Jardim de um convento medieval', 'Um mercado desde sempre', 'Um castelo real', 'Um jardim zoológico'],
      correctIndex: 0,
      funFact: 'O nome vem de "Convent Garden". Era o jardim dos monges de Westminster no século XIII.',
    ),
    Question(
      text: 'O que podes ver de graça no Covent Garden?',
      options: ['Artistas de rua e espetáculos', 'Um museu exclusivo', 'Um castelo', 'Um jardim fechado'],
      correctIndex: 0,
      funFact: 'O Covent Garden tem artistas de rua todos os dias: magos, músicos, acrobatas e palhaços!',
    ),
    Question(
      text: 'Que famoso museu fica mesmo ao lado da Trafalgar Square?',
      options: ['National Gallery (pintura)', 'British Museum', 'Museu da Ciência', 'Madame Tussauds'],
      correctIndex: 0,
      funFact: 'A National Gallery tem mais de 2300 pinturas e é completamente gratuita!',
    ),
    Question(
      text: 'Em que país foi a Batalha de Trafalgar?',
      options: ['No mar, perto de Espanha', 'Em Inglaterra', 'Em França', 'Em Portugal'],
      correctIndex: 0,
      funFact: 'A batalha foi no Cabo Trafalgar, junto à costa sul de Espanha, em outubro de 1805.',
    ),
    Question(
      text: 'O que são os famosos ecrãs da Piccadilly Circus?',
      options: ['Grandes painéis LED com publicidade', 'Ecrãs de cinema ao ar livre', 'Mapas da cidade', 'Transmissões de TV'],
      correctIndex: 0,
      funFact: 'Os ecrãs LED da Piccadilly Circus são tão famosos que aparecem em filmes e músicas do mundo inteiro!',
    ),
    Question(
      text: 'O que acontece na Trafalgar Square na Passagem de Ano?',
      options: ['Grandes festas com multidões', 'Corridas de cavalos', 'Concertos só para convidados', 'Torneios de xadrez'],
      correctIndex: 0,
      funFact: 'Milhares de pessoas juntam-se na Trafalgar Square para ver os fogos do Big Ben na Passagem de Ano!',
    ),
  ],
);

const _nhm = Attraction(
  id: 'nhm',
  name: 'Museu de História Natural',
  emoji: '🦕',
  color: Color(0xFF1B4A2B),
  description: 'Dinossauros, baleias e 80 milhões de espécimes. Entrada gratuita!',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Natural_History_Museum_London.jpg',
  questions: [
    Question(
      text: 'Qual o nome do esqueleto de baleia azul pendurado na sala principal?',
      options: ['Hope (Esperança)', 'Moby', 'Blue', 'Giant'],
      correctIndex: 0,
      funFact: '"Hope" significa Esperança. Foi escolhido para inspirar as gerações futuras a proteger os oceanos.',
    ),
    Question(
      text: 'Quantos metros tem o esqueleto da baleia azul Hope?',
      options: ['25 metros', '10 metros', '50 metros', '5 metros'],
      correctIndex: 0,
      funFact: 'Com 25 metros, é maior que um autocarro de dois andares! As baleias azuis são os maiores animais já conhecidos.',
    ),
    Question(
      text: 'Como se chama a sala principal do Museu de História Natural?',
      options: ['Hintze Hall', 'Blue Hall', 'Whale Hall', 'Ocean Gallery'],
      correctIndex: 0,
      funFact: 'Hintze Hall foi construída em 1881 e tem uma decoração incrível inspirada em catedrais medievais.',
    ),
    Question(
      text: 'Em que ano foi colocado o esqueleto da baleia na Hintze Hall?',
      options: ['2017', '2000', '1990', '1880'],
      correctIndex: 0,
      funFact: 'Antes da baleia, estava lá o Diplodocus "Dippy" desde 1979. A troca foi notícia em todo o mundo!',
    ),
    Question(
      text: 'Quantos espécimes tem a coleção do Museu de História Natural?',
      options: ['80 milhões', '1 milhão', '500 mil', '10 mil'],
      correctIndex: 0,
      funFact: '80 milhões de espécimes! Se vissem um por segundo, demorariam 2500 anos a ver tudo.',
    ),
    Question(
      text: 'Em que ano foi inaugurado o Museu de História Natural?',
      options: ['1881', '1900', '1945', '1800'],
      correctIndex: 0,
      funFact: 'O edifício foi desenhado por Alfred Waterhouse e demorou 8 anos a construir.',
    ),
    Question(
      text: 'Que material especial reveste a fachada exterior do museu?',
      options: ['Terracota (argila cozida)', 'Mármore branco', 'Granito cinzento', 'Calcário'],
      correctIndex: 0,
      funFact: 'A terracota laranja/castanha dá ao museu aquele aspeto único. Tem também animais esculpidos nas paredes!',
    ),
    Question(
      text: 'Quanto custa entrar no Museu de História Natural?',
      options: ['É completamente gratuito', '£15 por adulto', '£5 por criança', '£30 por família'],
      correctIndex: 0,
      funFact: 'É gratuito desde 2001! O Science Museum e o British Museum também são gratuitos. Londres é incrível!',
    ),
    Question(
      text: 'Que famosa rocha do espaço podes ver no museu?',
      options: ['Um meteorito de 4,5 mil milhões de anos', 'Uma pedra lunar', 'Um asteroide', 'Pó de cometa'],
      correctIndex: 0,
      funFact: 'O museu tem um meteorito que podes tocar! Tem 4,5 mil milhões de anos — mais velho que a Terra!',
    ),
    Question(
      text: 'Qual o nome do T-Rex famoso exposto no museu?',
      options: ['Stan', 'Rex', 'Terror', 'Tyra'],
      correctIndex: 0,
      funFact: '"Stan" é um dos T-Rex mais completos já descobertos. Foi encontrado em 1987 no Dakota do Sul, EUA.',
    ),
  ],
);

const _hydepark = Attraction(
  id: 'hydepark',
  name: 'Hyde Park & Kensington Gardens',
  emoji: '🌳',
  color: Color(0xFF1A3D1A),
  description: 'O maior parque real de Londres com o famoso Speakers\' Corner.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Hyde_Park,_London.jpg',
  questions: [
    Question(
      text: 'Como se chama o lago artificial no Hyde Park?',
      options: ['The Serpentine', 'Royal Lake', 'Blue Pond', 'Hyde Lake'],
      correctIndex: 0,
      funFact: 'O Serpentine tem este nome por causa da forma curva em S, como uma serpente!',
    ),
    Question(
      text: 'Como se chama o famoso canto para discursos no Hyde Park?',
      options: ["Speakers' Corner", 'Freedom Square', 'Talk Point', 'Open Mic Corner'],
      correctIndex: 0,
      funFact: 'Desde 1872 qualquer pessoa pode discursar aqui! Karl Marx e Lenin já discursaram neste mesmo local.',
    ),
    Question(
      text: 'A quem é dedicado o parque de brincar nos Kensington Gardens?',
      options: ['Princesa Diana', 'Rainha Victoria', 'Príncipe Carlos', 'Rei George'],
      correctIndex: 0,
      funFact: 'O Diana Memorial Playground tem um pirata de madeira gigante. A Princesa Diana adorava crianças!',
    ),
    Question(
      text: 'Kensington Palace é a residência de que membro da família real hoje?',
      options: ['Príncipe William e família', 'Rei Carlos III', 'Príncipe Harry', 'Princesa Ana'],
      correctIndex: 0,
      funFact: 'O Príncipe George, Princesa Charlotte e Príncipe Louis crescem no Kensington Palace!',
    ),
    Question(
      text: 'Qual a área total do Hyde Park?',
      options: ['142 hectares', '10 hectares', '500 hectares', '50 hectares'],
      correctIndex: 0,
      funFact: '142 hectares é maior que muitas aldeias portuguesas! É o 4º maior parque real de Londres.',
    ),
    Question(
      text: 'O que é a Serpentine Gallery no Hyde Park?',
      options: ['Um museu de arte moderna gratuito', 'Um restaurante flutuante', 'Uma piscina real', 'Uma loja de souvenirs'],
      correctIndex: 0,
      funFact: 'A Serpentine Gallery abre uma nova estrutura arquitetónica temporária todos os verões. É sempre diferente!',
    ),
    Question(
      text: 'Desde quando o Hyde Park está aberto ao público?',
      options: ['Desde 1637', 'Desde 1900', 'Desde 1800', 'Desde 1066'],
      correctIndex: 0,
      funFact: 'O Rei Carlos I abriu o Hyde Park ao público em 1637. Era antes uma reserva de caça privada do Rei Henrique VIII!',
    ),
    Question(
      text: 'O que podes fazer no lago Serpentine no verão?',
      options: ['Nadar e alugar barcos a remos', 'Só pescar', 'Nada, é decorativo', 'Patinar no gelo'],
      correctIndex: 0,
      funFact: 'A lido (piscina natural) do Serpentine está aberta todo o ano! No inverno os nadadores corajosos nadam no frio.',
    ),
    Question(
      text: 'Que famoso monumento em memória de Albert fica nos Kensington Gardens?',
      options: ['Albert Memorial', 'Victoria Monument', 'Prince Statue', 'Royal Cross'],
      correctIndex: 0,
      funFact: 'A Rainha Victoria mandou construir o Albert Memorial em honra do seu marido morto em 1861. Ela amava-o muito!',
    ),
    Question(
      text: 'O Hyde Park já recebeu concertos de que famosas bandas?',
      options: ['Rolling Stones, Queen, Madonna', 'Só músicos clássicos', 'Nunca teve concertos', 'Só bandas portuguesas'],
      correctIndex: 0,
      funFact: 'O Hyde Park é um dos maiores espaços de concertos do mundo! Os Rolling Stones já tocaram lá para 500 mil pessoas!',
    ),
  ],
);

const _sciencemuseum = Attraction(
  id: 'sciencemuseum',
  name: 'Museu da Ciência',
  emoji: '🚀',
  color: Color(0xFF2D1B69),
  description: 'Exploração espacial, máquinas a vapor e tecnologia. Gratuito!',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Science_Museum_London.jpg',
  questions: [
    Question(
      text: 'O Museu da Ciência é gratuito para entrar?',
      options: ['Sim, totalmente gratuito', 'Não, custa £15', 'Só para crianças', 'Só ao fim de semana'],
      correctIndex: 0,
      funFact: 'É gratuito! Só alguns simuladores e o IMAX têm custo extra.',
    ),
    Question(
      text: 'Que cápsula espacial famosa está exposta no Museu da Ciência?',
      options: ['Apollo 10 — foi à Lua!', 'Shuttle Columbia', 'Sputnik russo', 'Cápsula Vostok'],
      correctIndex: 0,
      funFact: 'A cápsula Apollo 10 orbitou a Lua em 1969, chegou a 14 km da superfície lunar mas não aterrou. Incrível!',
    ),
    Question(
      text: 'Em que ano abriu o Museu da Ciência?',
      options: ['1857', '1900', '1945', '2000'],
      correctIndex: 0,
      funFact: 'É um dos museus mais antigos do mundo dedicados à ciência e tecnologia.',
    ),
    Question(
      text: 'O que é o IMAX no Museu da Ciência?',
      options: ['Cinema com ecrã gigante e som surround', 'Um laboratório', 'Uma sala de jogos', 'Um restaurante'],
      correctIndex: 0,
      funFact: 'O ecrã IMAX tem 5 andares de altura! É como ver um filme dentro do filme.',
    ),
    Question(
      text: 'Que invenção revolucionária do século XVIII podes ver no museu?',
      options: ['Máquina a vapor de James Watt', 'O primeiro avião', 'O primeiro computador', 'O primeiro telefone'],
      correctIndex: 0,
      funFact: 'A máquina a vapor de Watt (1769) mudou o mundo e iniciou a Revolução Industrial!',
    ),
    Question(
      text: 'O Museu da Ciência fica ao lado de qual outro museu famoso?',
      options: ['Museu de História Natural', 'British Museum', 'Tate Modern', 'National Gallery'],
      correctIndex: 0,
      funFact: 'O NHM e o Museu da Ciência estão na mesma rua em South Kensington. Podes visitar os dois no mesmo dia!',
    ),
    Question(
      text: 'Que simulador emocionante existe no Museu da Ciência para crianças?',
      options: ['Simulador de lançamento espacial', 'Simulador de tornado', 'Simulador de tsunami', 'Simulador de terremoto'],
      correctIndex: 0,
      funFact: 'Podes sentir como é ser lançado numa nave espacial! A aceleração parece mesmo real.',
    ),
    Question(
      text: 'O que é o "Wonderlab" no Museu da Ciência?',
      options: ['Uma galeria interativa de experiências científicas', 'Um laboratório para cientistas', 'Uma loja', 'Um cinema'],
      correctIndex: 0,
      funFact: 'No Wonderlab podes tocar em raios elétricos, ver experiências com fogo e muito mais!',
    ),
    Question(
      text: 'Quem inventou o telefone, exposto no Museu da Ciência?',
      options: ['Alexander Graham Bell', 'Thomas Edison', 'Nikola Tesla', 'Marconi'],
      correctIndex: 0,
      funFact: 'Alexander Graham Bell fez a primeira chamada telefónica em 1876. Disse: "Mr. Watson, come here!"',
    ),
    Question(
      text: 'Que objeto do espaço podes tocar no Museu da Ciência?',
      options: ['Um fragmento de meteorito lunar', 'Uma rocha de Marte', 'Pó de asteroide', 'Um satélite real'],
      correctIndex: 0,
      funFact: 'Podes tocar numa rocha da Lua! Veio de uma missão Apollo e tem mais de 3 mil milhões de anos.',
    ),
  ],
);

const _britishmuseum = Attraction(
  id: 'britishmuseum',
  name: 'Museu Britânico',
  emoji: '🏛️',
  color: Color(0xFF4A3519),
  description: 'Múmias egípcias, a Pedra de Roseta e tesouros de todo o mundo.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/British_Museum_from_NE_2.JPG',
  questions: [
    Question(
      text: 'O que é a Pedra de Roseta no Museu Britânico?',
      options: ['Uma pedra com texto em 3 línguas que decifrou hieróglifos', 'Uma rocha lunar', 'Uma pedra preciosa', 'Uma pedra de uma pirâmide'],
      correctIndex: 0,
      funFact: 'A Pedra de Roseta foi a chave para decifrar os hieróglifos egípcios, uma escrita "morta" há séculos!',
    ),
    Question(
      text: 'Quantas línguas tem escritas a Pedra de Roseta?',
      options: ['3 línguas (hieróglifos, demótico, grego)', '2 línguas', '5 línguas', '1 língua'],
      correctIndex: 0,
      funFact: 'As 3 línguas dizem a mesma coisa! O grego (que os europeus sabiam ler) foi a chave para decifrar o resto.',
    ),
    Question(
      text: 'Quando foi descoberta a Pedra de Roseta?',
      options: ['1799, durante as guerras napoleónicas', '1900', '1500', '1066'],
      correctIndex: 0,
      funFact: 'Foi encontrada por soldados franceses de Napoleão em Rashid (Roseta), no Egito, em 1799.',
    ),
    Question(
      text: 'Como se chama a magnífica sala central coberta com teto de vidro?',
      options: ['Great Court', 'Glass Hall', 'Crystal Room', 'Royal Court'],
      correctIndex: 0,
      funFact: 'O Great Court foi projetado por Norman Foster e abriu em 2000. O teto de vidro tem 3312 painéis únicos!',
    ),
    Question(
      text: 'Quando foi fundado o Museu Britânico?',
      options: ['1753', '1800', '1900', '1066'],
      correctIndex: 0,
      funFact: 'É o primeiro museu público nacional do mundo! Abriu em 1759, seis anos depois de ser fundado.',
    ),
    Question(
      text: 'Quantos objetos tem a coleção do Museu Britânico?',
      options: ['Mais de 8 milhões', '100 mil', '1 milhão', '500'],
      correctIndex: 0,
      funFact: 'Só 80 mil estão expostos de cada vez. O resto está em reserva! Precisavas de 250 anos para ver tudo.',
    ),
    Question(
      text: 'As Esculturas do Partenon no British Museum vieram de onde?',
      options: ['Da Grécia (Atenas)', 'De Roma', 'Do Egito', 'Da Turquia'],
      correctIndex: 0,
      funFact: 'A Grécia pede o regresso das esculturas há décadas. É um dos maiores debates de museus do mundo!',
    ),
    Question(
      text: 'Quanto custa entrar no Museu Britânico?',
      options: ['É completamente gratuito', '£20', '£10', '£35'],
      correctIndex: 0,
      funFact: 'Gratuito desde 2001! Recebe 6 milhões de visitantes por ano — é o museu mais visitado do Reino Unido.',
    ),
    Question(
      text: 'As múmias egípcias são o quê exatamente?',
      options: ['Corpos humanos preservados artificialmente', 'Estátuas de pedra', 'Pinturas antigas', 'Documentos em papiro'],
      correctIndex: 0,
      funFact: 'Os egípcios preservavam os corpos com sal, resinas e bandagens. Acreditavam na vida após a morte!',
    ),
    Question(
      text: 'Qual o objeto egípcio mais famoso para além da Pedra de Roseta no British Museum?',
      options: ['Múmia de Katebet — tem 2800 anos!', 'Uma pirâmide miniatura', 'O cajado de Tutankamon', 'O trono de Ramsés'],
      correctIndex: 0,
      funFact: 'Katebet era uma cantora dos templos do Egipto Antigo. Podes vê-la de perto no museu!',
    ),
  ],
);

const _tussauds = Attraction(
  id: 'tussauds',
  name: 'Madame Tussauds',
  emoji: '🎭',
  color: Color(0xFF3D1A4A),
  description: 'Figuras de cera hiper-realistas de celebridades, reis e heróis.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Madame_Tussauds_London.jpg',
  questions: [
    Question(
      text: 'De onde era Madame Tussaud originalmente?',
      options: ['França (Estrasburgo)', 'Inglaterra', 'Alemanha', 'Espanha'],
      correctIndex: 0,
      funFact: 'Marie Tussaud nasceu em Estrasburgo em 1761 e aprendeu a fazer figuras de cera em Paris.',
    ),
    Question(
      text: 'De que material são feitas as figuras dos Madame Tussauds?',
      options: ['Cera', 'Plástico', 'Silicone', 'Resina'],
      correctIndex: 0,
      funFact: 'Cada figura demora 3 a 4 meses a criar e pode custar até 300 mil euros! Usam cabelo humano verdadeiro.',
    ),
    Question(
      text: 'Em que ano abriu o Madame Tussauds de Londres?',
      options: ['1835', '1900', '1970', '2000'],
      correctIndex: 0,
      funFact: 'Marie Tussaud abriu o museu ela própria em 1835, aos 74 anos! Viveu até aos 88.',
    ),
    Question(
      text: 'Quantas figuras de cera tem o Madame Tussauds de Londres?',
      options: ['Mais de 300', '10', '50', '1000'],
      correctIndex: 0,
      funFact: 'São mais de 300 figuras de celebridades de todo o mundo, incluindo figuras históricas e fictícias!',
    ),
    Question(
      text: 'Com quem aprendeu Madame Tussaud a fazer figuras de cera?',
      options: ['Com o Doutor Philippe Curtius em Paris', 'Com o seu pai', 'Com um escultor inglês', 'Sozinha'],
      correctIndex: 0,
      funFact: 'Curtius ensinou Marie quando ela tinha apenas 6 anos. A primeira figura que fez foi de Voltaire!',
    ),
    Question(
      text: 'Qual o desportista português mais famoso com figura no Madame Tussauds?',
      options: ['Cristiano Ronaldo', 'Eusébio', 'Luís Figo', 'Rui Costa'],
      correctIndex: 0,
      funFact: 'O CR7 tem figuras em vários Madame Tussauds do mundo! Em Londres podes tirar foto ao lado dele.',
    ),
    Question(
      text: 'O que podes fazer com as figuras de cera dos Madame Tussauds?',
      options: ['Tirar fotos ao lado e tocar (com cuidado)', 'Nada, só olhar', 'Levá-las para casa', 'Pintá-las'],
      correctIndex: 0,
      funFact: 'Podes abraçar, tirar selfies e posar com as figuras! É a parte mais divertida da visita.',
    ),
    Question(
      text: 'Que tipo de personagens podes encontrar nos Madame Tussauds?',
      options: ['Celebridades, políticos, desportistas, personagens de filmes', 'Só políticos', 'Só atores', 'Só músicos'],
      correctIndex: 0,
      funFact: 'Há desde o Rei Charles III até personagens da Marvel, passando por Harry Styles e Lionel Messi!',
    ),
    Question(
      text: 'O que é a "Chamber of Horrors" (Câmara dos Horrores)?',
      options: ['Sala com figuras de criminosos e cenas aterrorizantes', 'Um labirinto no escuro', 'Uma sala de filmes de terror', 'Animais selvagens'],
      correctIndex: 0,
      funFact: 'Marie Tussaud fez moldes de cabeças de pessoas guilhotinadas durante a Revolução Francesa. Histórico!',
    ),
    Question(
      text: 'Qual o preço aproximado de entrada no Madame Tussauds de Londres?',
      options: ['Cerca de £35-40 por adulto', 'É gratuito', '£5', '£100'],
      correctIndex: 0,
      funFact: 'É mais barato reservar online com antecedência! Às vezes há descontos de até 40%.',
    ),
  ],
);

const _buckingham = Attraction(
  id: 'buckingham',
  name: 'Buckingham Palace',
  emoji: '👑',
  color: Color(0xFF4A3A10),
  description: 'A residência oficial do Rei de Inglaterra e palco da famosa Troca da Guarda.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Buckingham_Palace,_London_-_April_2009.jpg',
  questions: [
    Question(
      text: 'Quantos quartos tem o Buckingham Palace?',
      options: ['775 quartos', '100 quartos', '50 quartos', '2000 quartos'],
      correctIndex: 0,
      funFact: 'Com 775 quartos (incluindo 52 quartos reais e 188 para pessoal), é maior que muitos hotéis!',
    ),
    Question(
      text: 'O que significa ver a bandeira hasteada no Buckingham Palace?',
      options: ['O Rei está em casa', 'Há uma celebração nacional', 'O palácio está aberto ao público', 'É um feriado'],
      correctIndex: 0,
      funFact: 'Quando o Rei está no palácio, hasteia-se o Royal Standard. Quando está fora, sobe a Union Jack.',
    ),
    Question(
      text: 'Qual é o nome da famosa cerimónia diária em frente ao palácio?',
      options: ['Troca da Guarda (Changing of the Guard)', 'Parada Real', 'Abertura do Parlamento', 'Cerimónia das Chaves'],
      correctIndex: 0,
      funFact: 'A Troca da Guarda acontece de manhã com música, marchas e uniformes vermelhos. Dura 45 minutos!',
    ),
    Question(
      text: 'Quantas janelas tem o Buckingham Palace?',
      options: ['760 janelas', '10 janelas', '100 janelas', '5000 janelas'],
      correctIndex: 0,
      funFact: 'Há uma equipa dedicada só a limpar as janelas! Deve ser um trabalho que nunca acaba...',
    ),
    Question(
      text: 'Como se chama o parque mesmo ao lado do Buckingham Palace?',
      options: ["St James's Park", 'Hyde Park', 'Green Park', "Regent's Park"],
      correctIndex: 0,
      funFact: "O St James's Park tem um lago famoso com pelicanos! Os pelicanos vivem lá desde 1664.",
    ),
    Question(
      text: 'Que animais incomuns vivem no lago do St James\'s Park?',
      options: ['Pelicanos', 'Flamingos', 'Crocodilos', 'Tigres'],
      correctIndex: 0,
      funFact: 'Os pelicanos do St James\'s Park são alimentados pelos tratadores todos os dias às 14:30. Podes ver!',
    ),
    Question(
      text: 'Em que ano o Buckingham Palace se tornou a residência oficial dos Reis?',
      options: ['1837, com a Rainha Victoria', '1066', '1900', '1600'],
      correctIndex: 0,
      funFact: 'A Rainha Victoria foi a primeira monarca a viver no Buckingham Palace em 1837, quando tinha apenas 18 anos!',
    ),
    Question(
      text: 'Quantas pessoas trabalham no Buckingham Palace?',
      options: ['Cerca de 800 pessoas', '10 pessoas', '5000 pessoas', '50 pessoas'],
      correctIndex: 0,
      funFact: 'Das 800 pessoas, há cozinheiros, jardineiros, cocheiros, mordomos e até um "Keeper of the Royal Philatelic Collection"!',
    ),
    Question(
      text: 'O jardim do Buckingham Palace é aberto ao público?',
      options: ['Sim, no verão para visitas guiadas', 'Nunca', 'Sempre, é gratuito', 'Só para a família real'],
      correctIndex: 0,
      funFact: 'No verão, o jardim com 16 hectares abre ao público. É onde o Rei organiza as famosas Garden Parties!',
    ),
    Question(
      text: 'Qual o símbolo que vês sempre no Palácio em vez da bandeira quando o Rei não está?',
      options: ['Union Jack (bandeira do Reino Unido)', 'Bandeira inglesa (Cruz de S. Jorge)', 'Bandeira europeia', 'Nenhuma bandeira'],
      correctIndex: 0,
      funFact: 'A Union Jack combina as cruzes de Inglaterra, Escócia e Irlanda. É uma das bandeiras mais reconhecíveis do mundo!',
    ),
  ],
);

const _toweroflondon = Attraction(
  id: 'toweroflondon',
  name: 'Torre de Londres',
  emoji: '🏰',
  color: Color(0xFF4A1A1A),
  description: 'Quase 1000 anos de história, Joias da Coroa e os famosos corvos.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Tower_of_London_viewed_from_the_River_Thames.jpg',
  questions: [
    Question(
      text: 'Quantos corvos têm de estar sempre na Torre de Londres, por decreto real?',
      options: ['Pelo menos 6', 'Exatamente 1', 'Pelo menos 100', 'Nenhum é obrigatório'],
      correctIndex: 0,
      funFact: 'Atualmente há 9 corvos na Torre! São: Jubilee, Harris, Gripp, Poppy, Erin, Thor, Huginn, Muninn e Branwen.',
    ),
    Question(
      text: 'O que acontece segundo a lenda se os corvos abandonarem a Torre?',
      options: ['O reino britânico vai cair', 'A Torre vai desaparecer', 'Vai haver uma tempestade', 'O Rei vai adoecer'],
      correctIndex: 0,
      funFact: 'Por isso cortam a ponta de uma asa a cada corvo para que não voem longe! É uma superstição levada a sério.',
    ),
    Question(
      text: 'Quem mandou construir a Torre de Londres?',
      options: ['Guilherme, o Conquistador (1078)', 'Henrique VIII', 'Rainha Victoria', 'Júlio César'],
      correctIndex: 0,
      funFact: 'Guilherme construiu a Torre depois de conquistar Inglaterra em 1066. Queria mostrar poder aos ingleses!',
    ),
    Question(
      text: 'Como se chamam os famosos guardas da Torre de Londres?',
      options: ['Beefeaters (Yeoman Warders)', 'Redcoats', 'Tower Guards', 'Royal Protectors'],
      correctIndex: 0,
      funFact: 'Os Beefeaters têm o uniforme Tudor vermelho e azul. Vivem dentro da Torre com as suas famílias!',
    ),
    Question(
      text: 'Qual o maior diamante das Joias da Coroa na Torre de Londres?',
      options: ['Cullinan I — a Grande Estrela de África', 'Diamante Hope', 'Koh-i-Noor', 'Diamante Orlov'],
      correctIndex: 0,
      funFact: 'O Cullinan I pesa 530 quilates e está cravado no cetro real. É o maior diamante lapidado do mundo!',
    ),
    Question(
      text: 'Como se chama a porta pela qual entravam os prisioneiros de barco?',
      options: ["Traitors' Gate (Porta dos Traidores)", 'Death Gate', 'River Door', 'Black Gate'],
      correctIndex: 0,
      funFact: "Ana Bolena, a segunda esposa de Henrique VIII, entrou pela Traitors' Gate antes de ser executada.",
    ),
    Question(
      text: 'A Torre de Londres tem quase quantos anos?',
      options: ['Quase 1000 anos', '200 anos', '500 anos', '2000 anos'],
      correctIndex: 0,
      funFact: 'Com quase 1000 anos, já foi palácio real, prisão, arsenal, tesouro, zoo e casa da moeda!',
    ),
    Question(
      text: 'Que famosa rainha foi decapitada na Torre de Londres?',
      options: ['Ana Bolena, esposa de Henrique VIII', 'Maria I', 'Isabel I', 'Catarina de Aragão'],
      correctIndex: 0,
      funFact: 'Henrique VIII teve 6 esposas. Executou 2: Ana Bolena e Catarina Howard. Ambas na Torre de Londres!',
    ),
    Question(
      text: 'O que são as Joias da Coroa?',
      options: ['Coroas, cetros e joias usadas nas coroações reais', 'Diamantes guardados num banco', 'Coleção de arte real', 'Moedas antigas'],
      correctIndex: 0,
      funFact: 'As Joias da Coroa incluem a Coroa do Estado Imperial com 2868 diamantes, 17 safiras, 11 esmeraldas e 269 pérolas!',
    ),
    Question(
      text: 'Em que rio fica a Torre de Londres?',
      options: ['Rio Tamisa', 'Rio Severn', 'Rio Avon', 'Canal da Mancha'],
      correctIndex: 0,
      funFact: 'A Tower Bridge fica mesmo ao lado da Torre de Londres, sobre o Tamisa. Podes ver as duas ao mesmo tempo!',
    ),
  ],
);

const _towerbridge = Attraction(
  id: 'towerbridge',
  name: 'Tower Bridge',
  emoji: '🌉',
  color: Color(0xFF1A2A4A),
  description: 'A ponte mais famosa de Londres que abre para deixar passar barcos.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Tower_Bridge_London.jpg',
  questions: [
    Question(
      text: 'Em que ano foi inaugurada a Tower Bridge?',
      options: ['1894', '1800', '1950', '1066'],
      correctIndex: 0,
      funFact: 'A construção demorou 8 anos e envolveu 432 trabalhadores. Foi inaugurada pelo Príncipe de Gales!',
    ),
    Question(
      text: 'Como se chama o tipo de ponte que abre para deixar passar barcos?',
      options: ['Ponte levadiça (bascule bridge)', 'Ponte suspensa', 'Ponte fixa', 'Ponte flutuante'],
      correctIndex: 0,
      funFact: 'As duas secções centrais abrem em 60 segundos! Os motores hidráulicos levantam 1200 toneladas.',
    ),
    Question(
      text: 'Quantas vezes abre a Tower Bridge por ano, aproximadamente?',
      options: ['Cerca de 800 vezes', '10 vezes', '5000 vezes', '1 vez por ano'],
      correctIndex: 0,
      funFact: 'Embarcações que precisem de passagem têm de avisar com 24h de antecedência. Os carros têm de esperar!',
    ),
    Question(
      text: 'O que há no topo da Tower Bridge para os turistas?',
      options: ['Passarela de vidro com vista do Tamisa', 'Um restaurante', 'Um hotel', 'Uma discoteca'],
      correctIndex: 0,
      funFact: 'Olhas para baixo e vês o rio e os carros a 42 metros de altura através do vidro. Assustador!',
    ),
    Question(
      text: 'A Tower Bridge é frequentemente confundida com que outra ponte?',
      options: ['London Bridge (a ponte mais simples ao lado)', 'Westminster Bridge', 'Millennium Bridge', 'Waterloo Bridge'],
      correctIndex: 0,
      funFact: 'Um americano comprou a London Bridge em 1968 pensando que era a Tower Bridge! Transportou-a pedra a pedra para o Arizona.',
    ),
    Question(
      text: 'Qual a cor da Tower Bridge?',
      options: ['Azul e branco', 'Vermelho', 'Verde', 'Cinzento'],
      correctIndex: 0,
      funFact: 'Antes das celebrações do Jubileu em 1977 era pintada de vermelho, branco e azul! Mudou para azul e branco.',
    ),
    Question(
      text: 'Qual a altura das torres da Tower Bridge?',
      options: ['65 metros', '10 metros', '200 metros', '135 metros'],
      correctIndex: 0,
      funFact: 'As torres foram construídas em pedra para parecerem medievais e combinar com a Torre de Londres ao lado.',
    ),
    Question(
      text: 'Quanto tempo demorou a construir a Tower Bridge?',
      options: ['8 anos (1886 a 1894)', '1 ano', '50 anos', '100 anos'],
      correctIndex: 0,
      funFact: 'Foram usadas 11 mil toneladas de aço na estrutura interior, depois coberto com pedra de Portland.',
    ),
    Question(
      text: 'A Tower Bridge fica perto da Torre de Londres?',
      options: ['Sim, ficam mesmo ao lado uma da outra', 'Não, ficam em bairros diferentes', 'Estão separadas pelo Tamisa', 'São o mesmo edifício'],
      correctIndex: 0,
      funFact: 'Podes ver as duas ao mesmo tempo numa fotografia! É um dos ângulos mais fotografados de Londres.',
    ),
    Question(
      text: 'Quantas pessoas cruzam a Tower Bridge por dia?',
      options: ['Cerca de 40.000 pessoas', '100 pessoas', '1 milhão', '500 pessoas'],
      correctIndex: 0,
      funFact: '40.000 por dia, 14 milhões por ano! É uma das pontes mais movimentadas de Londres.',
    ),
  ],
);

const _hmsBelfast = Attraction(
  id: 'hmsbelfast',
  name: 'HMS Belfast',
  emoji: '⚓',
  color: Color(0xFF0A1A3A),
  description: 'Navio de guerra da Segunda Guerra Mundial ancorado no Tamisa.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/HMS_Belfast.jpg',
  questions: [
    Question(
      text: 'O HMS Belfast é que tipo de navio de guerra?',
      options: ['Um cruzador pesado', 'Um porta-aviões', 'Um submarino', 'Um navio pirata'],
      correctIndex: 0,
      funFact: 'É um cruzador de 187 metros com 9 andares para explorar, desde a casa das máquinas até ao convés!',
    ),
    Question(
      text: 'Em que guerra famosa participou o HMS Belfast?',
      options: ['Segunda Guerra Mundial (1939-1945)', 'Primeira Guerra Mundial', 'Guerra das Malvinas', 'Guerra do Vietnam'],
      correctIndex: 0,
      funFact: 'O HMS Belfast entrou ao serviço em 1939, mesmo no início da Segunda Guerra Mundial.',
    ),
    Question(
      text: 'Em que operação histórica participou o HMS Belfast em junho de 1944?',
      options: ['Dia D — o desembarque na Normandia', 'Batalha de Inglaterra', 'Batalha do Atlântico', 'Operação Market Garden'],
      correctIndex: 0,
      funFact: 'No Dia D, o HMS Belfast foi o primeiro navio a disparar contra as defesas nazis na praia de Gold Beach!',
    ),
    Question(
      text: 'Quantos metros tem o HMS Belfast de comprimento?',
      options: ['187 metros', '50 metros', '500 metros', '100 metros'],
      correctIndex: 0,
      funFact: '187 metros é como 2 campos de futebol juntos! Era um dos navios mais modernos da sua época.',
    ),
    Question(
      text: 'Em que ano o HMS Belfast foi aberto ao público como museu?',
      options: ['1971', '2000', '1945', '1990'],
      correctIndex: 0,
      funFact: 'Foi preservado graças a uma campanha pública. Custou £2 milhões salvar o navio em 1971.',
    ),
    Question(
      text: 'O HMS Belfast faz parte de qual museu?',
      options: ['Imperial War Museum', 'British Museum', 'Science Museum', 'National Maritime Museum'],
      correctIndex: 0,
      funFact: 'O Imperial War Museum gere o HMS Belfast desde 1978. É o único navio de guerra sobrevivente da Segunda Guerra Mundial na Europa.',
    ),
    Question(
      text: 'Onde foi construído o HMS Belfast?',
      options: ['Belfast, Irlanda do Norte', 'Londres', 'Liverpool', 'Glasgow'],
      correctIndex: 0,
      funFact: 'Foi construído nos estaleiros Harland and Wolff em Belfast — o mesmo estaleiro que construiu o Titanic!',
    ),
    Question(
      text: 'O HMS Belfast ainda está em condições de navegar?',
      options: ['Não, é permanentemente ancorado como museu', 'Sim, navega todos os verões', 'Sim, serve a Marinha Real', 'Navega só em emergências'],
      correctIndex: 0,
      funFact: 'Está permanentemente ancorado no Tamisa desde 1971. Os motores ainda funcionam mas não navegará mais.',
    ),
    Question(
      text: 'O que podes fazer a bordo do HMS Belfast hoje?',
      options: ['Explorar 9 andares do navio incluindo casas das máquinas e torres de artilharia', 'Só ver o exterior', 'Dormir lá', 'Fazer mergulho'],
      correctIndex: 0,
      funFact: 'Podes entrar nas casas das máquinas, ver os dormitórios da tripulação e sentar na cadeira do comandante!',
    ),
    Question(
      text: 'Quantas pessoas compunham a tripulação do HMS Belfast durante a guerra?',
      options: ['Cerca de 950 homens', '10 homens', '50 homens', '10.000 homens'],
      correctIndex: 0,
      funFact: 'São 950 pessoas a viver e trabalhar num espaço fechado durante meses! Imagina a confusão nas filas para o jantar.',
    ),
  ],
);

const _stpauls = Attraction(
  id: 'stpauls',
  name: "St Paul's Cathedral",
  emoji: '⛪',
  color: Color(0xFF2A2A2A),
  description: 'A cúpula icónica de Londres com a famosa Galeria do Sussurro.',
  imageUrl: "https://commons.wikimedia.org/wiki/Special:FilePath/St_Paul's_Cathedral,_London.jpg",
  questions: [
    Question(
      text: 'Como se chama a galeria onde podes sussurrar e ser ouvido do outro lado?',
      options: ['Galeria do Sussurro', 'Galeria do Eco', 'Túnel do Som', 'Galeria Secreta'],
      correctIndex: 0,
      funFact: 'A Galeria do Sussurro fica a 30 metros de altura. O som viaja ao longo da parede curva da cúpula!',
    ),
    Question(
      text: 'Quem foi o arquiteto que projetou a St Paul\'s Cathedral atual?',
      options: ['Sir Christopher Wren', 'Sir Norman Foster', 'Inigo Jones', 'John Vanbrugh'],
      correctIndex: 0,
      funFact: 'Christopher Wren tinha 73 anos quando a catedral ficou concluída em 1710! Dedicou 35 anos à obra.',
    ),
    Question(
      text: 'Em que ano foi terminada a construção da St Paul\'s Cathedral?',
      options: ['1710', '1800', '1066', '1945'],
      correctIndex: 0,
      funFact: 'A primeira St Paul\'s foi destruída no Grande Incêndio de Londres de 1666. Wren projetou a nova de raiz!',
    ),
    Question(
      text: 'Por que evento destruidor foi necessário construir a St Paul\'s que existe hoje?',
      options: ['Grande Incêndio de Londres de 1666', 'Bombardeamento nazi na WWII', 'Um terramoto', 'Uma inundação do Tamisa'],
      correctIndex: 0,
      funFact: 'O Grande Incêndio de 1666 destruiu 13.200 casas e 87 igrejas em Lisboa... digo, em Londres! Durou 4 dias.',
    ),
    Question(
      text: 'Que evento histórico muito famoso aconteceu em St Paul\'s em 1981?',
      options: ['Casamento do Príncipe Carlos e Lady Diana', 'Coroação da Rainha Elizabeth', 'Funeral de Churchill', 'Abertura dos Jogos Olímpicos'],
      correctIndex: 0,
      funFact: '750 milhões de pessoas viram o casamento de Carlos e Diana na televisão em 1981. Foi o maior audiência da história na época!',
    ),
    Question(
      text: 'Quantos degraus tem a subida completa até à Golden Gallery (topo da cúpula)?',
      options: ['528 degraus', '100 degraus', '1000 degraus', '50 degraus'],
      correctIndex: 0,
      funFact: '528 degraus para a Golden Gallery no topo! Mas a Galeria do Sussurro fica apenas nos primeiros 257 degraus.',
    ),
    Question(
      text: 'Qual a vista que tens do topo da cúpula de St Paul\'s?',
      options: ['Panorâmica de 360° de toda Londres', 'Só o Tamisa', 'Só o Buckingham Palace', 'Nada, é fechado'],
      correctIndex: 0,
      funFact: 'Em dias limpos vês até Hampton Court a 24km de distância! A cúpula tem 111 metros de altura.',
    ),
    Question(
      text: 'A St Paul\'s Cathedral sobreviveu ao Blitz (bombardeamento nazi) da Segunda Guerra Mundial?',
      options: ['Sim, sobreviveu quase intacta', 'Não, foi destruída e reconstruída', 'Foi parcialmente destruída', 'Estava fechada durante a guerra'],
      correctIndex: 0,
      funFact: 'A fotografia da cúpula de St Paul\'s rodeada de fumo durante o Blitz tornou-se símbolo da resistência britânica!',
    ),
    Question(
      text: 'Quanto custa entrar em St Paul\'s Cathedral?',
      options: ['Cerca de £25 por adulto', 'É gratuito', '£5', '£100'],
      correctIndex: 0,
      funFact: 'A catedral precisa de receitas para a manutenção. Mas as missas são abertas ao público de graça!',
    ),
    Question(
      text: 'A St Paul\'s é a __ maior cúpula do mundo?',
      options: ['Quarta maior', 'A maior de todas', 'A segunda', 'A décima'],
      correctIndex: 0,
      funFact: 'É superada pela Basílica de São Pedro em Roma, o Panteão em Paris e a Igreja de Santa Maria del Fiore em Florença.',
    ),
  ],
);

const _millennium = Attraction(
  id: 'millennium',
  name: 'Millennium Bridge',
  emoji: '🌁',
  color: Color(0xFF2A3A4A),
  description: 'A ponte pedonal de aço que balançou na inauguração e ficou famosa em Harry Potter.',
  imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Millennium_Bridge,_London.jpg',
  questions: [
    Question(
      text: 'Em que ano foi inaugurada a Millennium Bridge?',
      options: ['2000', '1990', '2010', '1994'],
      correctIndex: 0,
      funFact: 'Foi inaugurada em junho de 2000 para celebrar o novo milénio. Mas a inauguração correu mal...',
    ),
    Question(
      text: 'O que aconteceu quando a Millennium Bridge foi inaugurada?',
      options: ['Balançava tanto que foi fechada no mesmo dia', 'Caiu no rio', 'Pegou fogo', 'Afundou'],
      correctIndex: 0,
      funFact: 'O movimento sincronizado dos passos de 90.000 pessoas no fim de semana inaugural fez a ponte oscilar até 7cm!',
    ),
    Question(
      text: 'Por quanto tempo foi fechada para reparação?',
      options: ['2 anos (2000 a 2002)', '1 semana', '10 anos', '1 dia'],
      correctIndex: 0,
      funFact: 'Foram instalados 37 amortecedores e 52 amortecedores de massa que custaram £5 milhões. Agora está completamente estável!',
    ),
    Question(
      text: 'Que dois pontos famosos liga a Millennium Bridge?',
      options: ["St Paul's Cathedral e Tate Modern", 'Tower Bridge e HMS Belfast', 'Westminster e London Eye', 'British Museum e Covent Garden'],
      correctIndex: 0,
      funFact: 'É a travessia pedonal mais direta entre a Tate Modern (sul) e St Paul\'s (norte). Uma vista magnífica!',
    ),
    Question(
      text: 'Em que filme famoso de Harry Potter aparece a Millennium Bridge?',
      options: ['Harry Potter e o Príncipe Misterioso (6)', 'A Pedra Filosofal (1)', 'As Relíquias da Morte (7)', 'O Cálice de Fogo (4)'],
      correctIndex: 0,
      funFact: 'No início de Harry Potter 6, os Death Eaters destroem a Millennium Bridge numa cena espetacular de efeitos especiais!',
    ),
    Question(
      text: 'Quantos metros tem a Millennium Bridge de comprimento?',
      options: ['325 metros', '50 metros', '1000 metros', '100 metros'],
      correctIndex: 0,
      funFact: 'São 325 metros de comprimento suspensos por apenas 8 cabos de aço de cada lado. Design muito minimalista!',
    ),
    Question(
      text: 'A Millennium Bridge é para:',
      options: ['Apenas peões (pedestres)', 'Peões e bicicletas', 'Carros e peões', 'Comboios'],
      correctIndex: 0,
      funFact: 'É a única ponte pedonal sobre o Tamisa no centro de Londres! Perfeita para uma caminhada com vista.',
    ),
    Question(
      text: 'O que é a Tate Modern, mesmo ao lado da Millennium Bridge?',
      options: ['Museu de arte moderna gratuito', 'Galeria paga de arte antiga', 'Uma universidade', 'Um hotel de luxo'],
      correctIndex: 0,
      funFact: 'A Tate Modern é um dos museus de arte moderna mais visitados do mundo com 6 milhões de visitantes por ano!',
    ),
    Question(
      text: 'Em que tipo de edifício funciona a Tate Modern?',
      options: ['Uma antiga central elétrica', 'Uma prisão', 'Uma fábrica de chocolates', 'Uma estação de comboios'],
      correctIndex: 0,
      funFact: 'A Bankside Power Station forneceu eletricidade a Londres de 1952 a 1981. A chaminé tem 99 metros!',
    ),
    Question(
      text: 'Quem projetou a Millennium Bridge?',
      options: ['Norman Foster e Anthony Caro', 'Christopher Wren', 'Zaha Hadid', 'Renzo Piano'],
      correctIndex: 0,
      funFact: 'Norman Foster também projetou o Great Court do British Museum! É um dos arquitetos mais famosos do mundo.',
    ),
  ],
);

/// All attractions keyed by ID for O(1) lookup
final Map<String, Attraction> attractionById = {
  for (final a in [
    _westminster, _trafalgar, _nhm, _hydepark, _sciencemuseum,
    _britishmuseum, _tussauds, _buckingham, _toweroflondon,
    _towerbridge, _hmsBelfast, _stpauls, _millennium,
  ]) a.id: a,
};

/// Default schedule: day number → attraction IDs (in order)
Map<int, List<String>> get defaultSchedule => {
  for (final d in tripDays) d.number: d.attractions.map((a) => a.id).toList(),
};

final List<Day> tripDays = [
  Day(
    number: 1,
    date: '29 Abril',
    title: 'Westminster, Trafalgar & Piccadilly',
    emoji: '🕰️',
    attractions: [_westminster, _trafalgar],
  ),
  Day(
    number: 2,
    date: '30 Abril',
    title: 'South Kensington & Parques',
    emoji: '🦕',
    attractions: [_nhm, _hydepark, _sciencemuseum],
  ),
  Day(
    number: 3,
    date: '1 Maio',
    title: 'Museus, Cera & Palácio Real',
    emoji: '👑',
    attractions: [_britishmuseum, _tussauds, _buckingham],
  ),
  Day(
    number: 4,
    date: '2 Maio',
    title: 'Torre, Tamisa & Pontes',
    emoji: '🏰',
    attractions: [_toweroflondon, _towerbridge, _hmsBelfast, _stpauls, _millennium],
  ),
];
