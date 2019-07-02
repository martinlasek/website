function formatNumber(num) {
	return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
}

const profileURL = "https://www.instagram.com/martin_lasek?__a=1";

fetch(profileURL)
	.then(response => response.json())
	.then(json => {
		document.querySelector(".instagram-count").innerHTML = formatNumber(json.graphql.user.edge_followed_by.count);
	})
;