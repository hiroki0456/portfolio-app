<template>
  <div class="answers">
    <div class="number">哲学者からの回答 {{ this.count }}件</div>
    <div class="box" v-for=" comment in this.$store.state.commentList " :key="comment.id">
      <h2 class="title">{{ comment.comment.title }}</h2>
      <div class="answer-box">
        <p>{{ comment.comment.comment }}</p>
        <span class="date">{{ comment.comment.created_at }}</span> 
        <div class="flexbox">
          <like-button :questionId="comment.comment.question_id" :commentId="comment.comment.id"></like-button>
        </div>
        <hr class="line"> 
        <div class="philosophia">
          <a href="#">
            <img :src="comment.image_url">
          </a>
          <div class="profile">
            <a href="#">{{ comment.user_name }}</a>
            <div class="introduce">
              {{ comment.profile }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
import LikeButton from '../like/LikeButton.vue'
import { mapGetters } from "vuex";

export default ({
  props: ['questionId'],
  components: { LikeButton },
  data() {
    return {
      // user: null,
      // image_url: "",
      // profile: ""
      // commentList: this.$store.state.commentList
    }
  },
  created() {
    this.fetchComment();
  },
    computed: {
    ...mapGetters("commentList", ["commentList"]),
    count() {
      return this.$store.state.commentList.length
    }
  },
  methods: {
    fetchComment: async function() {
      const res =  await axios.get(`/questions/${this.questionId}/comments`);
      console.log(res.data);
      return this.$store.commit('setComments', res.data);
    }
  }
})
</script>
