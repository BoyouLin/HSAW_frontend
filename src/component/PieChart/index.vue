<template>
  <v-chart class="piechart" :option="option" />
</template>

<script>
import * as echarts from "echarts/core";
import { CanvasRenderer } from "echarts/renderers";
import { PieChart } from "echarts/charts";
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
} from "echarts/components";
import VChart, { THEME_KEY } from "vue-echarts";
import { ref, watch, defineComponent } from "vue";
// import func from '../../../vue-temp/vue-editor-bridge'

echarts.use([
  CanvasRenderer,
  PieChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
]);

export default defineComponent({
  name: "pie_chart",
  components: {
    VChart,
  },
  provide: {
    [THEME_KEY]: "white", //dark
  },
  props: ["optionData"],
  setup(props) {
    const option = ref({});

    console.log(props.optionData);
    function reAssign() {
      option.value = {
        title: {
          //text: props.optionData["name"],
          left: "center",
        },
        tooltip: {
          trigger: "item",
          formatter: "{a}<br/>{b}分 : {c}次 ({d}%)",
        },
        series: [
          {
            name: props.optionData["name"],
            type: "pie",
            radius: "70%",
            center: ["50%", "50%"],
            data: [
              { value: props.optionData["score"][0], name: "1" },
              { value: props.optionData["score"][1], name: "2" },
              { value: props.optionData["score"][2], name: "3" },
              { value: props.optionData["score"][3], name: "4" },
              { value: props.optionData["score"][4], name: "5" },
            ],
            label: { fontSize: 20 },

            itemStyle: {
              normal: {
                color: function (colors) {
                  const colorList = [
                    "#BAFFB4",
                    "#F6DC66",
                    "#64D0DA",
                    "#FFAAA7",
                    "#B5EAEA",
                  ];
                  return colorList[colors.dataIndex];
                },
              },
            },

            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
            },
          },
        ],
      };
    }

    reAssign();

    watch(props, () => {
      if (props.optionData) {
        reAssign();
      }
    });

    return { option };
  },
});
</script>

<style src="./style.css"></style>
