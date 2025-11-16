<template>
  <div class="commands-container">
    <h2>Commands</h2>
    <ul class="commands-list">
      <li v-for="command in commands" :key="command.name">
        <strong>/{{ command.name }}</strong> - {{ command.description }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Commands',
  data() {
    return {
      commands: [],
    }
  },
  methods: {
    fetchCommands() {
      fetch(`https://qb-police-mdt/getCommands`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({})
      }).then(resp => resp.json()).then(resp => console.log(resp));
    },
    handleMessage(event) {
      if (event.data.type === 'receiveCommands') {
        this.commands = event.data.data;
      }
    }
  },
  mounted() {
    this.fetchCommands();
    window.addEventListener('message', this.handleMessage);
  },
  beforeUnmount() {
    window.removeEventListener('message', this.handleMessage);
  }
}
</script>

<style scoped>
.commands-container {
  color: #c5c6c7;
}

.commands-list {
  list-style: none;
  padding: 0;
}

.commands-list li {
  background-color: #25282c;
  padding: 15px;
  border-radius: 5px;
  margin-bottom: 10px;
}
</style>
