// Create a namespace for our module
const OrcamentosModule = (function() {
  // Private variables
  let orcamentos = [];
  let isInitialized = false;

  // Private functions
  async function carregarOrcamentos() {
    try {
      console.log('Fetching orcamentos...');
      const resp = await fetch('../php/listar_orcamentos.php');
      if (!resp.ok) {
        throw new Error(`HTTP error! status: ${resp.status}`);
      }
      const data = await resp.json();
      console.log('Received orcamentos:', data);
      orcamentos = data;
      renderizarTabela();
    } catch (error) {
      console.error('Error loading orcamentos:', error);
      alert('Erro ao carregar orçamentos. Por favor, tente novamente.');
    }
  }

  function renderizarTabela() {
    console.log('Rendering table with orcamentos:', orcamentos);
    const tbody = document.querySelector('#tabelaOrcamentos tbody');
    if (!tbody) {
      console.error('Table body element not found!');
      return;
    }
    tbody.innerHTML = '';

    const busca = document.getElementById('busca')?.value.toLowerCase() || '';
    const dataRange = document.getElementById('filtroData')?.value || '';

    const resultados = orcamentos.filter(o => {
      const matchBusca = o.nome_cliente.toLowerCase().includes(busca) 

      let matchData = true;

      if (dataRange) {
        const partes = dataRange.split(/ a | até /);

        const parseData = str => {
          const [d, m, a] = str.split('/');
          return new Date(`${a}-${m}-${d}T00:00:00`);
        };

        const [dataPart, horaPart] = o.data_hora.split(' ');
        const [dia, mes, ano] = dataPart.split('/');
        const [hora, minuto] = horaPart.split(':');
        const dataOrcamento = new Date(Number(ano), Number(mes) - 1, Number(dia), Number(hora), Number(minuto));

        if (partes.length === 1) {
          const dataSelecionada = parseData(partes[0]);
          matchData =
            dataOrcamento.getFullYear() === dataSelecionada.getFullYear() &&
            dataOrcamento.getMonth() === dataSelecionada.getMonth() &&
            dataOrcamento.getDate() === dataSelecionada.getDate();
        }

        if (partes.length === 2) {
          const inicio = parseData(partes[0]);
          const fim = parseData(partes[1]);
          const fimAjustado = new Date(fim.getTime() + 86399999); // fim do dia
          matchData = dataOrcamento >= inicio && dataOrcamento <= fimAjustado;
        }
      }

      return matchBusca && matchData;
    });

    console.log('Filtered resultados:', resultados);

    resultados.forEach(o => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${o.nome_cliente}</td>
        <td>${formatarData(o.data_hora)}</td>
        <td>${o.nome_arquivo}</td>
        <td>
          <button class="btn-ver-pdf" onclick="window.open('${o.caminho_arquivo}', '_blank')" title="Ver PDF">
            <i class="fa-solid fa-file-pdf"></i> PDF
          </button>
          <button class="btn-excluir" onclick="OrcamentosModule.deletarOrcamento(${o.id}, '${o.caminhoArquivo}')" title="Excluir Orçamento">
            <i class="fa-solid fa-trash"></i> Excluir
          </button>
        </td>
      `;
      tbody.appendChild(tr);
    });
  }

  function formatarData(dataStr) {
    const [dataPart, horaPart] = dataStr.split(' ');
    const [dia, mes, ano] = dataPart.split('/');
    return `${dia}/${mes}/${ano} ${horaPart}`;
  }

  async function deletarOrcamento(id, caminhoArquivo) {
    if (!confirm("Tem certeza que deseja excluir este orçamento?")) return;

    try {
      console.log('Deleting orcamento:', { id, caminhoArquivo });
      const form = new FormData();
      form.append('id', id);
      form.append('caminho', caminhoArquivo);

      const resp = await fetch('../php/excluir_orcamento.php', {
        method: 'POST',
        body: form
      });

      const result = await resp.text();
      console.log('Delete response:', result);

      if (!resp.ok) {
        console.error('Erro na exclusão:', result);
        alert('Erro ao excluir o orçamento.');
      } else {
        alert(result);
        carregarOrcamentos();
      }

    } catch (err) {
      console.error('Falha na requisição:', err);
      alert('Erro inesperado ao tentar excluir o orçamento.');
    }
  }

  function initializeApp() {
    if (isInitialized) {
      console.log('App already initialized');
      return;
    }

    console.log('Initializing app...');
    isInitialized = true;
    carregarOrcamentos();

    const buscaInput = document.getElementById('busca');
    const filtroDataInput = document.getElementById('filtroData');
    const limparFiltrosBtn = document.getElementById('limparFiltros');

    if (buscaInput) {
      buscaInput.addEventListener('input', renderizarTabela);
    }
    if (filtroDataInput) {
      filtroDataInput.addEventListener('change', renderizarTabela);
      flatpickr("#filtroData", {
        mode: "range",
        dateFormat: "d/m/Y",
        locale: "pt"
      });
    }
    if (limparFiltrosBtn) {
      limparFiltrosBtn.addEventListener('click', () => {
        if (buscaInput) buscaInput.value = '';
        if (filtroDataInput && filtroDataInput._flatpickr) {
          filtroDataInput._flatpickr.clear();
        }
        renderizarTabela();
      });
    }
  }

  // Public API
  return {
    deletarOrcamento,
    init: function() {
      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeApp);
      } else {
        initializeApp();
      }
    }
  };
})();

// Initialize the module
OrcamentosModule.init();