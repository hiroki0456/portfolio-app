<template>
  <div class="comment">
    <div class="comment-container">
      <div class="triangle"></div>
      <form action="/questions/2/comments" accept-charset="UTF-8" method="post">
        <div class="text-field">
          <input placeholder="タイトルを入力してください" type="text" name="title" v-model="title" id="comment_title">
        </div>
        <div class="text-field">
          <textarea rows="10" placeholder="回答を入力してください" name="comment" v-model="comment" id="comment_comment"></textarea>
        </div>
        <div class="comment-btn">
          <input type="submit" name="commit" value="回答する" v-on:click.prevent="createComment" data-disable-with="回答する">
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['questionId'],
  data() {
    return {
      title: "",
      comment: ""
    }
  },
  methods: {
    createComment: async function() {
      let formData = new FormData();
      formData.append("title", this.title);
      formData.append("comment", this.comment);

      const res = await axios.post(`/questions/${this.questionId}/comments`, formData);
      console.log(res.data);
      this.$store.commit('appendPost', res.data);
      this.resetForm();
    },
    resetForm: function() {
      this.title = "";
      this.comment = "";
    }
  }

}
</script>
