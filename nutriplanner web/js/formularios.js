function createTag(campo, input, valor) {
    const tag = document.createElement('span');
    tag.className = 'tag-removivel';
    tag.innerHTML = `${valor} <button type="button" class="remover-tag" aria-label="Remover">×</button>`;
    campo.insertBefore(tag, input);
}

function initTags(initialTags = {}) {
    document.querySelectorAll('.campo-tags').forEach((campo) => {
        const input = campo.querySelector('input');
        if (!input) return;

        const campoNome = campo.dataset.campo;

        if (campoNome && initialTags[campoNome]) {
            initialTags[campoNome].forEach((valor) => {
                createTag(campo, input, valor);
            });
        }

        input.addEventListener('keydown', (evento) => {
            if (evento.key === 'Enter' && input.value.trim() !== '') {
                evento.preventDefault();
                createTag(campo, input, input.value.trim());
                input.value = '';
            }
        });

        campo.addEventListener('click', (evento) => {
            if (evento.target.classList.contains('remover-tag')) {
                evento.target.closest('.tag-removivel').remove();
            }
        });
    });
}
