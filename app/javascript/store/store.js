"use strict"

import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

// Storeを生成
const store = new Vuex.Store({
    namespaced: true,
  state: { 
      commentList: []
   },
   getters: {
        commentList: state => state.commentList.sort((a, b) => b.id - a.id)
   },
   mutations: {
        setComments: (state, commentList) => (state.commentList = commentList),
        appendPost: (state, post) => (state.commentList = [...state.commentList, post])
   },
});
export default store;