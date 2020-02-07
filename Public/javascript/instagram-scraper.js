function formatNumber(num) {
	return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
}

const profileURL = "https://www.instagram.com/martin_lasek?__a=1";
let element = document.querySelector(`.instagram-count`);
if (element) {
	fetch(profileURL)
		.then(response => response.json())
		.then(json => {
			let element = document.querySelector(`.instagram-count`);
			element.innerHTML = formatNumber(json.graphql.user.edge_followed_by.count);
		})
}
