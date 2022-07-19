// function faz a funcionalidade de uma função que é chama nos elementos de HTML
// calcular() é a função proposta para fazer o calculo de um laço for
function Calcular() {
    // var é a representação de uma variavel que vai ser ultilizada dentro da função ou outras funcionalidades dentro do JavaScript
    // inicio é a variavel setada pelo comando var
    // window é o objeto do JavaScript de principal entrada para todos os recursos e APIs do JavaScript do lado do cliente
    // document é um elemento do metodo DOM (Document Object Model) fazendo a ligação do JavaScript com o HTML
    // .getElementById('') é o seletor do metodo DOM para escolher um elemento por ID 
    var inicio = window.document.getElementById('inicio')
    var final = window.document.getElementById('final')
    var passo = window.document.getElementById('passo')
    var res = window.document.getElementById('res')
    // estrutura de decisão if else com as condições dentro dos ()
    if(inicio.value.length == 0 || final.value.length == 0 || passo.value.length == 0){
        // window é o objeto do JavaScript de principal entrada para todos os recursos e APIs do JavaScript com o HTML
        // alert('') cria uma mensagem visivel ao usuario pelo browser 
        window.alert('Faltam Dados!')
        // res nesse caso, esta sendo a representação de um ID no HTML para poder recever os inputs gerados pelo script
        // innerHTML define ou obtem a sintax HTML ou XML pode ser possivel fazer configurações como se estivesse escrevendo um codigo HTML
        res.innerHTML = 'Impossivel contar!'
    } else {
        res.innerHTML = 'Contando: '
        // let é um quantificador de variavel de escopo de bloco, mais adequado para ser usado dentro de funções ou de suas fincionalidades internas
        // Number é um objeto encapsulado que permite você a trabalhar com valores numericos, sejam inteiros ou reais
        // .value seleciona o que você quer vai receber informação para ser usado na função
        let i = Number(inicio.value)
        let f = Number(final.value)
        let p = Number(passo.value)
        if (p <= 0){
            window.alert('Impossivel começar! Considerando passo 1')
            p = 1
        }
        if (i < f) {
            // for é um laço de decisão onde (inicio;fim;passo) inicio normalmente representado com let -variavel- para demonstrar o inicio, -variavel- para representar o final do laço e -variavel- para representar como vai ser a sequencia do começo ao fim
            for (let index = i; index <= f; index += p) {
                // para fazer a introdução de emoji no codigo de JavaScript U+1F449 diferente do HTML, no JavaScript você usa \u{} substituindo U+ no codigo do emoji ficando nesse caso \u{1f449}
                res.innerHTML += `${index} 👉 `
            }
        }  else {
            for (let index = i; index <= f; index -= p) {
                res.innerHTML += `${index} 👉 `
            }
        }
    }
    res.innerHTML += `🏁`

}