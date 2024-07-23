  // graficos de barra 
  const data = {
    labels: ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'],
    datasets: [{
      label: 'Libros vendidos mensualmente',
      data: [12, 11, 9, 15, 20, 9],
      backgroundColor:'#FF5C77',
    }]
  };

  // config 
  const config = {
    type: 'bar',
    data,
    options: {
        maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  };

  // render init block
  const myChart = new Chart(
    document.getElementById('myChart'),
    config
  );

  // Instantly assign Chart.js version
  const chartVersion = document.getElementById('chartVersion');
  chartVersion.innerText = Chart.version;





  // graficos de linea 


  const ctx = document.getElementById('mChart');
              
new Chart(ctx, {
  type: 'line',
  data: {
    labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'],
    datasets: [{
      label: '# of Votes',
      data: [74, 200, 50, 25,175],
      borderWidth: 1,
      backgroundColor:'#F7B32B',
    }]
  },
  options: {
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});


const pieGraph = (canvas, legends, values, title) => {
    // Se declara un arreglo para guardar códigos de colores en formato hexadecimal.
    let colors = [];
    // Se generan códigos hexadecimales de 6 cifras de acuerdo con el número de datos a mostrar y se agregan al arreglo.
    values.forEach(() => {
        colors.push('#' + (Math.random().toString(16)).substring(2, 8));
    });
    // Se crea una instancia para generar el gráfico con los datos recibidos.
    new Chart(document.getElementById(canvas), {
        type: 'pie',
        data: {
            labels: legends,
            datasets: [{
                data: values,
                backgroundColor: colors
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: title
                }
            }
        }
    });
}