<template>
  <div class="thanks-button">
    <div class="thanks-num">{{ count }}</div>
    <input v-if="isLiked" type="submit" value="自由になった" class="thanks" disabled="disabled">
    <input v-else @click="registerLike()" type="submit" value="自由になった" class="thanks">
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  props: ['userId', 'questionId', 'commentId'],
  data() {
    return {
      likeList: []
    }
  },
  computed: {
    count() {
      return this.likeList.length
    },
    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId())
    },
  },
  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result
    })
  },
  methods: {
    fetchLikeByPostId: async function() {
      const res = await axios.get(`/questions/${this.questionId}/comments/find_like?comment_id=${this.commentId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    registerLike: async function() {
      const res = await axios.get(`/questions/${this.questionId}/comments/${this.commentId}/like`);
      if (res.status !== 201) { process.exit() }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result
      })
    },
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId)
      })
      if (like) { return like.id }
    }
  }
}
</script>