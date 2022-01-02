
-- NOTE: Change this to search
set SEARCH_TEXT to "blueberries"

-- NOTE: Assumes we are on orders page
--		 Manually change time period
--		 Stops on first occurence found
tell application "Google Chrome" to tell active tab of window 1
	-- Clicks on warehouse orders
	execute javascript "document.getElementById('warehouseOrdersTab').click()"
	-- Go through paginated pages
	set isLastPage to false
	repeat until isLastPage
		set isLastPage to (execute javascript "document.querySelector('button[aria-label=\"Go to next page\"').disabled")
		-- Loop through all the receipts on this page
		set numReceipts to (execute javascript "document.querySelectorAll('button[aria-describedby*=\"view-receipt\"').length")
		set i to 0
		repeat until i is numReceipts
			-- Open receipt
			execute javascript "document.querySelectorAll('button[aria-describedby*=\"view-receipt\"')[" & i & "].click()"
			delay 0.5
			-- Check content
			set source to execute javascript "document.documentElement.outerHTML"
			ignoring case
				if source contains SEARCH_TEXT then
					return
				end if
			end ignoring
			-- Close receipt
			execute javascript "document.querySelector('button.MuiButtonBase-root.MuiIconButton-root').click()"
			set i to i + 1
		end repeat
		execute javascript "document.querySelector('button[aria-label=\"Go to next page\"').click()"
	end repeat
end tell

-- do shell script "echo The value: " & numReceipts
