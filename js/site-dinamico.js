document.addEventListener('DOMContentLoaded', () => {
    carregarServicos();
    carregarDepoimentos();
    configurarFormularioOrcamento();
    configurarFormularioDepoimento();
});


async function buscarDados(url) {
    const resposta = await fetch(url, {
        headers: {
            'Accept': 'application/json'
        }
    });

    if (!resposta.ok) {
        throw new Error('Falha na comunicação com o servidor.');
    }

    return resposta.json();
}


async function carregarServicos() {
    const area = document.querySelector('#lista-servicos');

    if (!area) return;

    try {
        const servicos = await buscarDados('api/listar_servicos.php');

        area.replaceChildren();

        servicos.forEach(servico => {
            const coluna = document.createElement('div');
            coluna.className = 'col-md-4';

            const card = document.createElement('div');
            card.className = 'card card-service h-100';

            const imagem = document.createElement('img');
            imagem.src = servico.imagem;
            imagem.alt = servico.nome;
            imagem.className = 'card-img-top';

            const corpo = document.createElement('div');
            corpo.className = 'card-body';

            const titulo = document.createElement('h3');
            titulo.className = 'h4';
            titulo.textContent = servico.nome;

            const descricao = document.createElement('p');
            descricao.className = 'text-muted';
            descricao.textContent = servico.descricao;

            const preco = document.createElement('p');
            preco.className = 'price-tag';
            preco.textContent = 'Orçamento personalizado';

            corpo.append(titulo, descricao, preco);

            const rodape = document.createElement('div');
            rodape.className = 'card-footer bg-white border-0 pb-3 d-grid';

            const link = document.createElement('a');
            link.href = servico.pagina;
            link.className = 'btn btn-gold';
            link.textContent = 'Solicitar orçamento';

            rodape.append(link);

            card.append(imagem, corpo, rodape);
            coluna.append(card);
            area.append(coluna);
        });

    } catch (erro) {
        area.textContent = 'Não foi possível carregar os serviços.';
        console.error(erro);
    }
}

async function carregarDepoimentos() {
    const area = document.querySelector('#lista-depoimentos');

    if (!area) return;

    try {
        const depoimentos = await buscarDados('api/listar_depoimentos.php');

        area.replaceChildren();

        depoimentos.forEach(depoimento => {
            const coluna = document.createElement('div');
            coluna.className = 'col-md-5';

            const cartao = document.createElement('div');
            cartao.className = 'testimonial-card';

            const nome = document.createElement('p');
            nome.className = 'small text-muted mb-1';
            nome.textContent = depoimento.nome;

            const titulo = document.createElement('h4');
            titulo.textContent = depoimento.titulo;

            const texto = document.createElement('p');
            texto.className = 'mb-0 fst-italic';
            texto.textContent = `“${depoimento.texto}”`;

            cartao.append(nome, titulo, texto);
            coluna.append(cartao);
            area.append(coluna);
        });

        if (depoimentos.length === 0) {
            area.textContent = 'Ainda não há depoimentos aprovados.';
        }

    } catch (erro) {
        area.textContent = 'Não foi possível carregar os depoimentos.';
        console.error(erro);
    }
}

function configurarFormularioOrcamento() {
    const form = document.querySelector('#form-orcamento');

    if (!form) return;

    form.addEventListener('submit', async (evento) => {
        evento.preventDefault();

        const botao = form.querySelector('[type="submit"]');
        const feedback = form.querySelector('[data-feedback]');

        botao.disabled = true;
        feedback.textContent = 'Enviando...';

        try {
            const resposta = await fetch('api/salvar_orcamento.php', {
                method: 'POST',
                body: new FormData(form)
            });

            const dados = await resposta.json();

            feedback.textContent = dados.mensagem;
            feedback.className = dados.sucesso
                ? 'text-success mt-3'
                : 'text-danger mt-3';

            if (dados.sucesso) {
                form.reset();
            }

        } catch (erro) {
            feedback.textContent =
                'Não foi possível enviar. Verifique se Apache e MySQL estão ativos.';

            feedback.className = 'text-danger mt-3';
            console.error(erro);

        } finally {
            botao.disabled = false;
        }
    });
}

function configurarFormularioDepoimento() {
    const form = document.querySelector('#form-depoimento');

    if (!form) return;

    form.addEventListener('submit', async (evento) => {
        evento.preventDefault();

        const botao = form.querySelector('[type="submit"]');
        const feedback = form.querySelector('[data-feedback]');

        botao.disabled = true;
        feedback.textContent = 'Enviando...';

        try {
            const resposta = await fetch('api/salvar_depoimento.php', {
                method: 'POST',
                body: new FormData(form)
            });

            const dados = await resposta.json();

            feedback.textContent = dados.mensagem;
            feedback.className = dados.sucesso
                ? 'text-success mt-3'
                : 'text-danger mt-3';

            if (dados.sucesso) {
                form.reset();
            }

        } catch (erro) {
            feedback.textContent =
                'Não foi possível enviar o depoimento.';

            feedback.className = 'text-danger mt-3';
            console.error(erro);

        } finally {
            botao.disabled = false;
        }
    });
}