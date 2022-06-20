<template>
  <div class="total-pie-four">
    <h2 class="total-pie-text">本館1F藥劑科</h2>
    <v-chart class="piechart1" :option="option1"></v-chart>
  </div>
  <div class="total-pie-four">
    <h2 class="total-pie-text">一分館B1眼科藥局</h2>
    <v-chart class="piechart2" :option="option2"></v-chart>
  </div>
</template>

<script>
import * as echarts from 'echarts/core'
import { CanvasRenderer } from 'echarts/renderers'
import { PieChart } from 'echarts/charts'
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
} from 'echarts/components'
import VChart, { THEME_KEY } from 'vue-echarts'
import { ref, watch, defineComponent } from 'vue'

echarts.use([
  CanvasRenderer,
  PieChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
])

export default defineComponent({
  name: 'total_pie_chart',
  components: {
    VChart,
  },
  provide: {
    [THEME_KEY]: 'white', //dark
  },
  props: ['score1', 'score2'],
  setup(props) {
    const option1 = ref({})
    const option2 = ref({})

    function reAssign() {
      option1.value = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}分 : {c}次 ({d}%)',
        },
        series: [
          {
            name: '本館1F藥劑科',
            type: 'pie',
            radius: '75%',
            center: ['50%', '60%'],
            data: [
              { value: props.score1[0], name: '1' },
              { value: props.score1[1], name: '2' },
              { value: props.score1[2], name: '3' },
              { value: props.score1[3], name: '4' },
              { value: props.score1[4], name: '5' },
            ],

            itemStyle: {
              normal: {
                color: function (colors) {
                  const colorList = [
                    '#BAFFB4',
                    '#F6DC66',
                    '#64D0DA',
                    '#FFAAA7',
                    '#B5EAEA',
                  ]
                  return colorList[colors.dataIndex]
                },
              },
            },

            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)',
              },
            },
          },
        ],
      }

      option2.value = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}分 : {c}次 ({d}%)',
        },
        series: [
          {
            name: '一分館B1眼科藥局',
            type: 'pie',
            radius: '75%',
            center: ['50%', '60%'],
            data: [
              { value: props.score2[0], name: '1' },
              { value: props.score2[1], name: '2' },
              { value: props.score2[2], name: '3' },
              { value: props.score2[3], name: '4' },
              { value: props.score2[4], name: '5' },
            ],

            itemStyle: {
              normal: {
                color: function (colors) {
                  const colorList = [
                    '#BAFFB4',
                    '#F6DC66',
                    '#64D0DA',
                    '#FFAAA7',
                    '#B5EAEA',
                  ]
                  return colorList[colors.dataIndex]
                },
              },
            },

            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)',
              },
            },
          },
        ],
      }
    }

    reAssign()

    watch(props, () => {
      reAssign()
    })

    return { option1, option2 }
  },
})
</script>
<style src="./style.css"></style>