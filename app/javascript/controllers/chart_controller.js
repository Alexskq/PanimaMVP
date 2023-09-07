import { Chart } from 'chart.js';
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['myChart', "cogs", "salesprofit", "categories"];
  static values = {
    sales: Array,
    cogs: Array,
    profit: Array,
    categories: Object
  }
  chartInstance = null;
  connect(){
    this.salesprofit()
  }

  choice(event) {
    const old = document.querySelectorAll(".btn-chart");
    console.log(old);
    // if (old.length > 0) {
    //   old[0].classList.remove("toggle");
    // }
    old.forEach((element) => {
      console.log(element)
      element.classList.remove("toggle")
    })

    // event.currentTarget.classList.add("toggle");

    if (event.currentTarget === this.cogsTarget) {
      this.cogs();
    } else if (event.currentTarget === this.salesprofitTarget) {
      this.salesprofit();
    } else if (event.currentTarget === this.categoriesTarget) {
      this.categories();
    }
  }


    salesprofit() {
      const startDate = new Date();
      startDate.setDate(1); // Set to the first day of the current month
      const endDate = new Date(); // Set to today's date
      const jour = this.generateDaysArray(startDate, endDate);
      this.salesprofitTarget.classList.add("toggle")
      const type = 'line'
      const data = {
        labels: jour,
        datasets: [
          {
            label: "Ventes journalières",
            backgroundColor: "rgba(220,220,220,0.2)",
            borderColor: "#9CA3D6",
            data: this.salesValue
          },
          {
              label: "Profit",
              backgroundColor: "rgba(151,187,205,0.2)",
              borderColor: "rgba(151,187,205,1)",
              data: this.profitValue
            }
          ]
        };

        const ctx = this.myChartTarget.getContext('2d');
        this.createOrUpdateChartInstance(ctx, data, type);
      }

      cogs(event) {
        const startDate = new Date();
        startDate.setDate(1); // Set to the first day of the current month
        const endDate = new Date(); // Set to today's date
        const jour = this.generateDaysArray(startDate, endDate);
        this.cogsTarget.classList.add("toggle")
        const type = 'line'
        const data = {
          labels: jour,
          datasets: [
            {
              label: "Cout des marchandises vendues",
              backgroundColor: "rgba(220,220,220,0.2)",
              borderColor: "#9CA3D6",
              data: this.cogsValue
            },
            // {
            //   label: "Profit",
            //   backgroundColor: "rgba(151,187,205,0.2)",
            //   borderColor: "rgba(151,187,205,1)",
            //   data: this.data.get('@profit')
            // }
          ]
        };

        const ctx = this.myChartTarget.getContext('2d');
        this.createOrUpdateChartInstance(ctx, data, type);
      }

      categories(event) {
        const labels = []
        const data_set = []
        this.categoriesTarget.classList.add("toggle")

        for (const [key, value] of Object.entries(this.categoriesValue)){
          labels.push(key)
          data_set.push(value)
        }
        function generateColors(count) {
          const colors = [];
          const hueStep = 360 / count;

          for (let i = 0; i < count; i++) {
            const hue = i * hueStep;
            const color = `hsl(${hue}, 70%, 50%)`; // Adjust saturation and lightness as desired
            colors.push(color);
          }

          return colors;
        }

        const type = 'pie'
        const data = {
          labels: labels,
          datasets: [
            {
              label: labels,
              borderColor: "#9CA3D6",
              data: data_set,
              backgroundColor: generateColors(labels.length),
            },
          ],
        };
        const ctx = this.myChartTarget.getContext('2d');
        if (this.chartInstance) {
          this.chartInstance.destroy();
        }

        this.chartInstance = new Chart(ctx, {

          type: 'pie',
          data: data,
          options: {
            plugins: {
              legend: {
                position: 'right'
              },
              title: {
                display: false
              },
              gridLines:{
                display: false
              }
            },
            scales: {
              x: {
                display: true,
              },
              y: {
                display: true,
              }
            },
            layout: {
              padding: 0
            },
          },
        });
      }



      createOrUpdateChartInstance(ctx, data, type) {
        if (this.chartInstance) {
          this.chartInstance.destroy();
        }

        this.chartInstance = new Chart(ctx, {
          type: type,
          data: data,
          options: {
            scales: {
              x: {
                title: {
                  display: true,
                  text: 'Days of the Month'
                }
              },
              y: {
                title: {
                  display: true,
                  text: 'Amount in Euros'
                }
              },
            }
          }
        });
      }

      generateDaysArray(startDate, endDate){
        const jour = [];
        const currentDate = new Date(startDate);
        while (currentDate <= endDate) {
          jour.push(currentDate.getDate());
          currentDate.setDate(currentDate.getDate() + 1);
        }
        return jour;
      }
    }
