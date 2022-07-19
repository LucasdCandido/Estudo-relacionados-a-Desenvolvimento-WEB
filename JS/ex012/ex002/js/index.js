
function carregar() {
    var fano = window.document.getElementById('idade')
    var dia = new Date()
    var ano = dia.getFullYear()
    if (fano.value.length == 0 && Number(fano.value) > ano) {
        window.alert('Você digitou um ano errado, digite novamente')
    } else {
        var fsex = document.getElementsByName('radsex')
        var idade = ano - Number(fano.value)
        var genero = ''
        var img = document.createElement('img')
        img.setAttribute('id', 'foto')
        if (fsex[0].checked){
            genero = 'Homem'
            if (idade >= 0 && idade < 20) {
                img.setAttribute('src', 'img/crianca-menino.png')
            } else if (idade < 50) {
                img.setAttribute('src', 'img/adulto-homem.png')
            } else {
                img.setAttribute('src', 'img/idoso.png')
            }
        } else if (fsex[1].checked){
            genero = 'Mulher'
            if (idade >= 0 && idade < 20) {
                img.setAttribute('src', 'img/crianca-menina.png')
            } else if (idade < 50) {
                img.setAttribute('src', 'img/adulto-mulher.png')
            } else {
                img.setAttribute('src', 'img/idosa.png')
            }
        }
        res.style.textAlign = 'center'
        res.innerHTML = `Detectamos ${genero} com ${idade} anos. <br>`
        res.appendChild(img)
    }
}