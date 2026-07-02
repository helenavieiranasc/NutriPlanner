function initDashboard() {
    fetch('containersidebar.html')
        .then(response => {
            if (!response.ok) throw new Error('Falha ao carregar sidebar partial');
            return response.text();
        })
        .then(data => {
            const placeholder = document.getElementById('containersidebar');
            if (placeholder) {
                placeholder.outerHTML = data;
            }

            setTimeout(() => {
                const path = window.location.pathname.toLowerCase();

                document.querySelectorAll('.item-menu').forEach(item => item.classList.remove('ativo'));

                if (path.includes('home.html')) {
                    const icon = document.querySelector('.item-menu .icone-home');
                    if (icon) icon.closest('.item-menu').classList.add('ativo');
                } else if (path.includes('listapacientes.html') || path.includes('cadastrarpaciente.html') || path.includes('editarpaciente.html') || path.includes('criarplano.html') || path.includes('verpaciente.html')) {
                    const icon = document.querySelector('.item-menu .icone-pacientes');
                    if (icon) icon.closest('.item-menu').classList.add('ativo');
                } else if (path.includes('basealimentos.html')) {
                    const icon = document.querySelector('.item-menu .icone-alimentos');
                    if (icon) icon.closest('.item-menu').classList.add('ativo');
                } else if (path.includes('configuracoes.html')) {
                    const icon = document.querySelector('.item-menu .icone-config');
                    if (icon) icon.closest('.item-menu').classList.add('ativo');
                }

                const toggleBtn = document.getElementById('toggleSidebar');
                const sidebar = document.getElementById('painelLateral');
                const mainContent = document.querySelector('.conteudo-dashboard');
                const overlay = document.getElementById('overlaySidebar');

                if (toggleBtn && sidebar && mainContent) {
                    toggleBtn.addEventListener('click', () => {
                        if (window.innerWidth <= 1024) {
                            sidebar.classList.toggle('aberto');
                            if (overlay) overlay.classList.toggle('visivel');
                        } else {
                            sidebar.classList.toggle('fechado');
                            mainContent.classList.toggle('expandido');
                        }
                    });
                }

                if (overlay && sidebar) {
                    overlay.addEventListener('click', () => {
                        sidebar.classList.remove('aberto');
                        overlay.classList.remove('visivel');
                    });
                }

                const logoutBtn = document.querySelector('.botao-sair');
                if (logoutBtn) {
                    logoutBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        if (confirm('Deseja sair do sistema?')) {
                            localStorage.removeItem('nutriplanner_current_user');
                            window.location.href = '../index.html';
                        }
                    });
                }

                const currentUserStr = localStorage.getItem('nutriplanner_current_user');
                if (currentUserStr) {
                    const currentUser = JSON.parse(currentUserStr);
                    const nomeEl = document.querySelector('.nome-perfil');
                    const emailEl = document.querySelector('.email-perfil');
                    const avatarEl = document.querySelector('.avatar-iniciais');

                    if (nomeEl) nomeEl.textContent = currentUser.nome;
                    if (emailEl) {
                        const userTag = currentUser.email.split('@')[0];
                        emailEl.textContent = '@' + userTag;
                    }
                    if (avatarEl && currentUser.nome) {
                        const iniciais = currentUser.nome
                            .split(' ')
                            .filter(Boolean)
                            .map(n => n[0])
                            .slice(0, 2)
                            .join('')
                            .toUpperCase();
                        avatarEl.textContent = iniciais;
                    }

                    const path = window.location.pathname.toLowerCase();
                    const boasVindasNome = document.querySelector('.bloco-boas-vindas h1 .destaque-nome');
                    if (boasVindasNome && (path.includes('home.html') || path.endsWith('/') || path.includes('index.html'))) {
                        const h1 = document.querySelector('.bloco-boas-vindas h1');
                        if (h1 && h1.textContent.includes('Olá')) {
                            const primeiroNome = currentUser.nome.trim().split(' ')[0];
                            boasVindasNome.textContent = primeiroNome + '!';
                        }
                    }
                }
            }, 20);
        })
        .catch(error => console.error('Erro ao injetar menu lateral:', error));

    const dataEl = document.querySelector('.data-atual');
    if (dataEl) {
        const text = dataEl.textContent.trim();
        if (text === '' || !text.includes('Tabela TACO')) {
            const hoje = new Date();
            dataEl.textContent = hoje.toLocaleDateString('pt-BR', {
                weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
            });
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    initDashboard();

    document.addEventListener('click', (e) => {
        const target = e.target;

        const salvarPacienteSelecionado = () => {
            const container = target.closest('.cartao-paciente') || target.closest('tr') || target.closest('.lista-perfil');
            if (container) {
                const nomeEl = container.querySelector('.nome-paciente') ||
                               container.querySelector('.dados-paciente strong') ||
                               container.querySelector('.lista-dados strong');
                if (nomeEl) {
                    localStorage.setItem('nutriplanner_selected_patient_name', nomeEl.textContent.trim());
                }
            }
        };

        if (target.classList.contains('botao-novopaciente') || target.closest('.botao-novopaciente')) {
            e.preventDefault();
            window.location.href = 'cadastrarpaciente.html';
        }

        if (target.classList.contains('botao-novoalimento') || target.closest('.botao-novoalimento')) {
            e.preventDefault();
            window.location.href = 'emdesenvolvimento.html';
        }

        if (target.classList.contains('botao-ver') || target.classList.contains('botao-texto')) {
            if (
                !target.closest('#formCadastroPaciente') &&
                !target.closest('#formEditarPaciente') &&
                !target.closest('.rodape-tabela')
            ) {
                e.preventDefault();
                salvarPacienteSelecionado();
                window.location.href = 'verpaciente.html';
            }
        }

        if (target.classList.contains('botao-plano') || target.classList.contains('botao-ver-plano')) {
            e.preventDefault();
            salvarPacienteSelecionado();
            window.location.href = 'verpaciente.html#planopaciente';
        }

        if (target.classList.contains('botao-criar-plano')) {
            e.preventDefault();
            salvarPacienteSelecionado();
            window.location.href = 'criarplano.html';
        }
    });
});
