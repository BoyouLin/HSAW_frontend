<template>
  <div class="backstage">
    <div class="Bheader">
      <div class="Bheader_text">
        <h4>起迄日</h4>
        <h4>選擇地區</h4>
        <h4>選擇員工</h4>
      </div>
      <!-- 選擇器 -->
      <div class="Bheader_select">
        <div class="input_date">
          <div class="Bheader_select_datebox">
            <input type="date" v-model="date[0]" :max="date[1]" required />
            <!-- @change="dateChange($event)" -->
          </div>
          <div class="input_date_line"></div>
          <div class="Bheader_select_datebox">
            <input type="date" v-model="date[1]" :min="date[0]" required />
          </div>
        </div>

        <div class="Bheader_select_box">
          <input
            type="button"
            :value="placesList[department][place]"
            class="input_place"
            @click="isShowList('P')"
            :class="{ Bheader_select_box_bg_select: placeListShow }"
          />
          <ul class="select_place_list" v-show="placeListShow">
            <li
              class="option"
              v-for="(value, key) in placesList[department]"
              :key="key"
              @click="isShowList('P', key)"
            >
              {{ value }}
            </li>
          </ul>
        </div>

        <div class="Bheader_select_box">
          <input
            type="button"
            :value="employeesList[employee]"
            class="input_employee"
            @click="isShowList('E')"
            :class="{ Bheader_select_box_bg_select: employeeListShow }"
          />
          <ul class="select_employee_list" v-show="employeeListShow">
            <li
              class="option"
              v-for="(value, key) in employeesList"
              :key="key"
              @click="isShowList('E', key)"
            >
              {{ value }}
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="Bcontainer">
      <!-- 選部門的菜單 -->
      <div class="Bmenu">
        <ul class="Bmenu_ul">
          <li v-for="obj in departmentsList" :key="obj['id']">
            <label
              ><input
                type="radio"
                name="label"
                :value="obj.id"
                v-model="department"
              />
              <p class="Bmenu_button">{{ obj.name }}</p>
            </label>
          </li>
        </ul>
      </div>

      <!-- 圖表 -->

      <div class="Bcontent" v-if="mode == 1">
        <h4 class="chart_title">平均分數</h4>
        <div class="bar_chart">
          <bar-chart
            :optionData="hostipalSearchResult"
            :mode="mode"
            @barClick="department = $event"
          >
          </bar-chart>
        </div>
        <h4 class="chart_title">平均分數比較</h4>
        <div class="line_chart">
          <div class="chart_two_date">
            <div class="input_date_1">
              <div class="select_datebox1">
                <input type="date" v-model="date[0]" :max="date[1]" required />
              </div>
              <div class="input_date_line1"></div>
              <div class="select_datebox1">
                <input type="date" v-model="date[1]" :min="date[0]" required />
              </div>
            </div>

            <div class="input_date_2">
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[0]"
                  :max="date2[1]"
                  required
                />
              </div>
              <div class="input_date_line2"></div>
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[1]"
                  :min="date2[0]"
                  required
                />
              </div>
            </div>
          </div>
          <line-chart
            :optionData1="hostipalSearchResult"
            :optionData2="hostipalSearchResult2"
            :date1="date"
            :date2="date2"
            :mode="mode"
            @barClick="department = $event"
          ></line-chart>
        </div>
        <h4 class="chart_title">評分次數統計</h4>

        <div class="legend_box">
          <div v-for="n in 5" :key="n" :class="'legend legend' + n">
            <div class="box"></div>
            <div class="text">{{ n }}分</div>
          </div>
        </div>
        <div class="pie_chart">
          <div v-for="(item, key) in hostipalSearchResult" :key="key">
            <h3 class="pie_chart_title">{{ item["name"] }}</h3>
            <pie-chart :optionData="item"></pie-chart>
          </div>
        </div>
      </div>

      <div class="Bcontent" v-else-if="mode == 2">
        <h4 class="chart_title">平均分數</h4>
        <div class="bar_chart">
          <bar-chart
            :optionData="deartmentSearchResult"
            :mode="mode"
            @barClick="place = $event"
          >
          </bar-chart>
        </div>
        <h4 class="chart_title">平均分數比較</h4>
        <div class="line_chart">
          <div class="chart_two_date">
            <div class="input_date_1">
              <div class="select_datebox1">
                <input type="date" v-model="date[0]" :max="date[1]" required />
              </div>
              <div class="input_date_line1"></div>
              <div class="select_datebox1">
                <input type="date" v-model="date[1]" :min="date[0]" required />
              </div>
            </div>

            <div class="input_date_2">
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[0]"
                  :max="date2[1]"
                  required
                />
              </div>
              <div class="input_date_line2"></div>
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[1]"
                  :min="date2[0]"
                  required
                />
              </div>
            </div>
          </div>
          <line-chart
            :optionData1="deartmentSearchResult"
            :optionData2="deartmentSearchResult2"
            :date1="date"
            :date2="date2"
            :mode="mode"
            @barClick="place = $event"
          ></line-chart>
        </div>
        <h4 class="chart_title">評分次數統計</h4>
        <div class="legend_box">
          <div v-for="n in 5" :key="n" :class="'legend legend' + n">
            <div class="box"></div>
            <div class="text">{{ n }}分</div>
          </div>
        </div>
        <div class="pie_chart">
          <div v-for="(item, key) in deartmentSearchResult" :key="key">
            <h3 class="pie_chart_title">{{ item["name"] }}</h3>
            <pie-chart :optionData="item"></pie-chart>
          </div>
        </div>
      </div>

      <div class="Bcontent" v-else-if="mode == 3">
        <h4 class="chart_title">員工一覽</h4>
        <table class="table_chart">
          <thead>
            <tr>
              <th class="table_id" scope="col">員工編號</th>
              <th class="table_name" scope="col">姓名</th>
              <th class="table_times" scope="col">評分次數</th>
              <th class="table_average" scope="col">平均分數</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(value, key) in placeSearchResult" :key="key">
              <td class="table_id">
                <input
                  type="button"
                  class="table_row_button"
                  :value="key"
                  @click="employee = key"
                />
                <h5>{{ key }}</h5>
              </td>
              <td class="table_name">{{ value["name"] }}</td>
              <td class="table_times">{{ value["times"] }}</td>
              <td class="table_average">{{ value["average"] }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="Bcontent" v-else-if="mode == 4">
        <h4 class="chart_title">平均分數比較</h4>
        <div class="bar_chart_employee">
          <div class="chart_two_date">
            <div class="input_date_1">
              <div class="select_datebox1">
                <input type="date" v-model="date[0]" :max="date[1]" required />
              </div>
              <div class="input_date_line1"></div>
              <div class="select_datebox1">
                <input type="date" v-model="date[1]" :min="date[0]" required />
              </div>
            </div>

            <div class="input_date_2">
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[0]"
                  :max="date2[1]"
                  required
                />
              </div>
              <div class="input_date_line2"></div>
              <div class="select_datebox2">
                <input
                  type="date"
                  v-model="date2[1]"
                  :min="date2[0]"
                  required
                />
              </div>
            </div>
          </div>
          <div class="bar_chart_employee_container">
            <bar-chart-straight
              :optionData1="placeSearchResult[employee]"
              :optionData2="placeSearchResult2[employee]"
              :mode="mode"
            ></bar-chart-straight>
          </div>
        </div>
        <h4 class="chart_title">評分次數統計</h4>
        <div class="legend_box">
          <div v-for="n in 5" :key="n" :class="'legend legend' + n">
            <div class="box"></div>
            <div class="text">{{ n }}分</div>
          </div>
        </div>
        <div class="pie_chart_employee">
          <pie-chart :optionData="placeSearchResult[employee]"></pie-chart>
          <h4>總共：{{ placeSearchResult[employee]["times"] }}次</h4>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, watch } from "vue";
import axios from "axios";
import BarChart from "../component/BarChart/index.vue";
import LineChart from "../component/LineChart/index.vue";
import PieChart from "../component/PieChart/index.vue";
import BarChartStraight from "../component/BarChartStraight/index.vue";

export default {
  components: {
    BarChart,
    LineChart,
    PieChart,
    BarChartStraight,
  },
  setup() {
    // const date = reactive([
    //   new Date().toISOString().slice(0, 10),
    //   new Date().toISOString().slice(0, 10),
    // ]);
    // const date2 = reactive([
    //   new Date().toISOString().slice(0, 10),
    //   new Date().toISOString().slice(0, 10),
    // ]);
    //這是測試用的日期
    const date = reactive(["2022-05-10", "2022-05-15"]);
    const date2 = reactive(["2022-05-15", "2022-05-20"]);
    const department = ref("000");
    const place = ref("000");
    const employee = ref(""); //000
    const placeListShow = ref(false);
    const hostipalSearchResult = ref({});
    const deartmentSearchResult = ref({});
    const hostipalSearchResult2 = ref({});
    const deartmentSearchResult2 = ref({});
    const placeSearchResult = ref({});
    const placeSearchResult2 = ref({});
    const employeeListShow = ref(false);
    const mode = ref(0);
    const departmentsList = [
      { id: "000", name: "檢視全部" },
      { id: "A", name: "行政部門" },
      { id: "B", name: "檢驗部門" },
      { id: "C", name: "檢查部門" },
      { id: "D", name: "藥劑部門" },
    ];
    const placesList = {
      "000": {
        "000": "請先選擇部門",
      },
      A: {
        "000": "所有地區",
        "001": "本館1F門診櫃台",
        "002": "本館1F住院櫃台",
        "003": "本館1F急診櫃台",
        "004": "本館3F門診櫃台",
        "005": "一分館1F門診櫃台",
      },
      B: { "000": "所有地區", "001": "本館1F抽血櫃台" },
      C: {
        "000": "所有地區",
        "001": "本館B1放射科櫃台",
        "002": "本館B1_CT檢查室",
        "003": "本館B1_MRI放射科櫃台",
        "004": "二分館1F_640檢查室",
        "005": "二分館B1_檢查室",
        "006": "二分館5F_檢查室",
        "007": "二分館1F_內視鏡檢查室",
        "008": "本館1F_內視鏡檢查室",
        "009": "本館3F_婦產科檢查室",
        "010": "本館3F_耳鼻喉科檢查室",
        "011": "二分館B1眼科檢查室",
        "012": "本館3F肌電圖室",
        "013": "本館B1心障超音波檢查室",
        "014": "本館B1核子醫學科檢查室",
      },
      D: {
        "000": "所有地區",
        "001": "本館1F藥劑科",
        "002": "一分館B1眼科藥局",
      },
    };
    const employeesList = ref({
      "000": "所有人員",
    });

    function all_analyze(dateFlag) {
      const d = { 0: date, 2: date2 };
      return new Promise((resolve) => {
        axios
          .post(
            "https://hospitalstaffassessmentserver.azurewebsites.net:443/all_analyze",
            {
              start_date: d[dateFlag][0],
              end_date: d[dateFlag][1],
            }
          )
          .then((res) => {
            if (dateFlag == 0) {
              hostipalSearchResult.value = res.data;
              console.log(hostipalSearchResult.value);
              console.log("全院查詢");
            } else if (dateFlag == 2) {
              hostipalSearchResult2.value = res.data;
              console.log(hostipalSearchResult2.value);
              console.log("全院查詢2");
            }
            resolve();
          });
      });
    }

    function department_analyze(dateFlag) {
      const d = { 0: date, 2: date2 };
      return new Promise((resolve) => {
        axios
          .post(
            "https://hospitalstaffassessmentserver.azurewebsites.net:443/department_analyze",
            {
              start_date: d[dateFlag][0],
              end_date: d[dateFlag][1],
              department_ID: department.value,
            }
          )
          .then((res) => {
            if (dateFlag == 0) {
              deartmentSearchResult.value = res.data;
              console.log(deartmentSearchResult.value);
              console.log(department.value + "部門查詢");
            } else if (dateFlag == 2) {
              deartmentSearchResult2.value = res.data;
              console.log(deartmentSearchResult2.value);
              console.log(department.value + "部門查詢2");
            }
            resolve();
          });
      });
    }

    function place_analyze(dateFlag) {
      const d = { 0: date, 2: date2 };
      return new Promise((resolve) => {
        axios
          .post(
            "https://hospitalstaffassessmentserver.azurewebsites.net:443/sub_department_analyze",
            {
              start_date: d[dateFlag][0],
              end_date: d[dateFlag][1],
              department_ID: department.value,
              place_sub_number: place.value,
            }
          )
          .then((res) => {
            if (dateFlag == 0) {
              placeSearchResult.value = res.data;
              console.log(placeSearchResult.value);
              console.log(department.value + "部門" + place.value + "地點查詢");
            } else if (dateFlag == 2) {
              placeSearchResult2.value = res.data;
              console.log(placeSearchResult2.value);
              console.log(
                department.value + "部門" + place.value + "地點查詢2"
              );
            }

            resolve();
          });
      });
    }

    function get_employee_options() {
      axios
        .post(
          "https://hospitalstaffassessmentserver.azurewebsites.net:443/get_employee_options",
          {
            start_date: date[0],
            end_date: date[1],
            department_ID: department.value,
            place_sub_number: place.value,
          }
        )
        .then((res) => {
          employeesList.value = res.data;
          console.log("已載入員工選項名單");
        });
    }

    function isShowList(selector, key) {
      if (selector == "P") {
        employeeListShow.value = false;
        placeListShow.value =
          department.value != "000" ? !placeListShow.value : false;
        if (key) {
          place.value = key;
        }
      }
      if (selector == "E") {
        employeeListShow.value =
          department.value != "000" && place.value != 0
            ? !employeeListShow.value
            : false;
        if (key) {
          employee.value = key;
        }
        if (employee.value !== "000") {
          console.log("指定員工：" + employee.value);
        }
      }
    }

    watch(date, () => {
      if (mode.value == 4) {
        employee.value = "000";
      }
    });
    //處理比對資料，可能可以再優化
    watch(date2, () => {
      if (mode.value == 1) {
        all_analyze(2);
      } else if (mode.value == 2) {
        department_analyze(2);
      } else if (mode.value == 4) {
        place_analyze(2);
      }
    });
    watch(department, () => {
      place.value = "000";
      employee.value = "000";
    });

    watch(place, () => {
      employee.value = "000";
    });
    watch(
      //判斷篩選方式，mode:1全院查詢，2部門查詢,3地點查詢,4顯示個別員工
      [department, place, employee, date],
      async ([departmentNew, placeNew, employeeNew]) => {
        placeListShow.value = false;
        employeeListShow.value = false;
        if (departmentNew == "000") {
          await all_analyze(0);
          await all_analyze(2);
          mode.value = 1;
        } else if (placeNew == "000") {
          await department_analyze(0);
          await department_analyze(2);
          mode.value = 2;
        } else if (employeeNew == "000") {
          get_employee_options(); //取得員工選單
          await place_analyze(0);
          mode.value = 3;
        } else {
          await place_analyze(2);
          mode.value = 4;
        }
      },
      { immediate: true }
    );

    return {
      mode,
      date,
      date2,
      department,
      place,
      employee,
      departmentsList,
      placesList,
      employeesList,
      placeListShow,
      employeeListShow,
      hostipalSearchResult,
      deartmentSearchResult,
      placeSearchResult,
      hostipalSearchResult2,
      deartmentSearchResult2,
      placeSearchResult2,
      all_analyze,
      department_analyze,
      place_analyze,
      get_employee_options,
      isShowList,
    };
  },
  mounted() {},
  updated() {},
};
</script>

<style type="text/css" src="@/assets/style.css"></style>
